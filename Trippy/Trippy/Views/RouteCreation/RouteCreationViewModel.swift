//
//  RouteCreationViewModel.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import Foundation
import Utils
import Domain
import Repository

final class RouteCreationViewModel: ViewModel {
    
    struct Flow {
        var addWaypoint: Callback?
        var proceed: Callback?
    }
    
    private let flow: Flow
    
    private let routeRepository: RouteRepository
    
    @Published var intermediateWaypoints: [WaypointData] = []
    @Published var startWaypoint: WaypointData?
    @Published var endWaypoint: WaypointData?
    
    // MARK: - Initialization
    
    init(flow: Flow,
         routeRepository: RouteRepository) {
        self.flow = flow
        self.routeRepository = routeRepository
        
    }
    
    private func getWaypoints() {
        let waypoints = routeRepository.getAll()
        
        guard let firstWaypoint = waypoints.first,
              let lastWaypoint = waypoints.last else {
            initializeStartingWaypoints()
            return
        }
        
        startWaypoint = firstWaypoint
        endWaypoint = lastWaypoint
        
        guard waypoints.count > 2 else {
            intermediateWaypoints = []
            return
        }
        
        let lastIntermediateWaypointIndex = waypoints.count - 2
        intermediateWaypoints = Array(waypoints[1...lastIntermediateWaypointIndex])
    }
    
    private func initializeStartingWaypoints() {
        startWaypoint = .init(id: UUID().uuidString,
                              name: "Unreal country, unknown city",
                              date: .init())
        
        endWaypoint = .init(id: UUID().uuidString,
                            name: "Unreal country, unknown city",
                            date: .init())
    }
    
    func insertWaypoint(at position: Int) {
        intermediateWaypoints.insert(WaypointData(id: "",
                                                  name: "Taganrog, Grecheskaya 104A|\(intermediateWaypoints.count)",
                                                  date: Date()),
                                     at: position)
    }
    
    func proceed() {
        flow.proceed?()
    }
}
