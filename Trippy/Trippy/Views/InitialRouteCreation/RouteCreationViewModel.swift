//
//  RouteCreationViewModel.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import Foundation
import Utils
import Domain

final class RouteCreationViewModel: ViewModel {
    struct Flow {
        var addWaypoint: Callback?
    }
    
    private let flow: Flow
    
    @Published var intermediateWaypoints: [WaypointData] = []
    @Published var startWaypoint: WaypointData = WaypointData(name: "Taganrog, Grecheskaya 104A",
                                                              date: Date())
    @Published var endWaypoint: WaypointData = .init(name: "",
                                                     date: Date())
    
    init(flow: Flow) {
        self.flow = flow
    }
    
    func insertWaypoint(at position: Int) {
        intermediateWaypoints.insert(WaypointData(name: "Taganrog, Grecheskaya 104A|\(intermediateWaypoints.count)",
                                                  date: Date()),
                                     at: position)
    }
}
