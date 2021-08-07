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
    
    func loadData() {
        let waypoints = routeRepository.getAll()
        
        setCornerWaypoints(usingWaypoints: waypoints)
        setIntermediateWaypoints(usingWaypoints: waypoints)
    }
    
    private func setCornerWaypoints(usingWaypoints waypoints: [WaypointData]) {
        guard let firstWaypoint = waypoints.first,
              let lastWaypoint = waypoints.last else {
            initializeStartingWaypoints()
            return
        }
        
        startWaypoint = firstWaypoint
        endWaypoint = lastWaypoint
    }
    
    private func setIntermediateWaypoints(usingWaypoints waypoints: [WaypointData]) {
        guard waypoints.count > 2 else {
            intermediateWaypoints = []
            return
        }
        
        let lastIntermediateWaypointIndex = waypoints.count - 2
        intermediateWaypoints = Array(waypoints[1...lastIntermediateWaypointIndex])
    }
    
    private func initializeStartingWaypoints() {
        // TODO: Use geocoding tool to get data for it
        startWaypoint = nil
        endWaypoint = nil
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
