//
//  RouteCreationViewModel.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import Foundation
import Utils

struct WaypointData {
    let name: String
}

extension WaypointData {
    static var mock: WaypointData {
        .init(name: "Taganrog, Grecheskaya street, 104A")
    }
}

final class RouteCreationViewModel: ViewModel {
    struct Flow {
        var addWaypoint: Callback?
    }
    
    private let flow: Flow
    
    @Published var intermediateWaypoints: [WaypointData] = [.mock,
                                                            .mock]
    
    init(flow: Flow) {
        self.flow = flow
    }
    
    func addWaypoint() {
        intermediateWaypoints.append(.mock)
        flow.addWaypoint?()
    }
    
    func insertWaypoint(at position: Int) {
        intermediateWaypoints.insert(.mock,
                                     at: position)
    }
}
