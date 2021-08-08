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
    
    private let routeController: IRouteController
    
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var intermediateWaypoints: [WaypointData] = []
    @Published var startWaypoint: WaypointData?
    @Published var endWaypoint: WaypointData?
    
    // MARK: - Initialization
    
    init(flow: Flow,
         routeController: IRouteController) {
        self.flow = flow
        self.routeController = routeController
    }
    
    func loadData() {
        routeController.getWaypoints()
            .sink { [weak self] result in
                switch result {
                case .success(let data):
                    self?.setCornerWaypoints(usingWaypoints: data)
                    self?.setIntermediateWaypoints(usingWaypoints: data)
                    
                case .failure:
                    // TODO: Push event to common error publisher
                    break
                }
            }
            .store(in: &cancelBag)
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
        routeController.addWaypoint(waypointData: waypointData)
            .sink { result in
                switch result {
                case .success:
                    break
                    
                case .failure:
                    break // TODO: Handle error
                }
            }
            .store(in: &cancelBag)
    }
    
    func proceed() {
        flow.proceed?()
    }
}
