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
import RouteController
import Combine

// TODO: REMOVE IT AFTER WAYPOINT CREATION LOGIC will be created.
import TestUtils

final class RouteCreationViewModel: ViewModel {
    
    struct Flow {
        var addWaypoint: Callback?
        var proceed: Callback?
    }
    
    private let flow: Flow
    
    private let routeRepository: IRouteRepository
    private let routeController: IRouteController
    
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var intermediateWaypoints: [WaypointData] = []
    @Published var startWaypoint: WaypointData?
    @Published var endWaypoint: WaypointData?
    
    // MARK: - Initialization
    
    init(flow: Flow,
         // TODO: Remove route repository and use route controller
         routeRepository: IRouteRepository,
         routeController: IRouteController) {
        self.flow = flow
        self.routeRepository = routeRepository
        self.routeController = routeController
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
        routeController.initiateStartWaypoint()
            .sink { [weak self] result in
                switch result {
                case .success(let data):
                    self?.startWaypoint = data
                    self?.endWaypoint = self?.startWaypoint
                    
                case .failure:
                    break
                }
            }
            .store(in: &cancelBag)
    }
    
    func insertWaypoint(at position: Int) {
        let mockIncrementedDate: Date
        if intermediateWaypoints.isEmpty {
            mockIncrementedDate = Date.date(addingDays: 1, addingHours: 1, from: startWaypoint!.date)
        } else {
            mockIncrementedDate = Date.date(addingDays: 1, addingHours: 1, from: intermediateWaypoints.first!.date)
        }
        
        let waypointData = WaypointData(id: "",
                                       name: "Taganrog, Grecheskaya 104A|\(intermediateWaypoints.count)",
                                       date: mockIncrementedDate)
        
        intermediateWaypoints.insert(waypointData,
                                     at: position)
        routeRepository.insert(waypointData)
    }
    
    func proceed() {
        flow.proceed?()
    }
}
