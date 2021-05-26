//
//  RouteCreationViewModel.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import Foundation

struct WaypointData {
    let name: String
}

extension WaypointData {
    static var mock: WaypointData {
        .init(name: "Taganrog, Grecheskaya street, 104A")
    }
}

final class RouteCreationViewModel: ObservableObject {
    @Published var intermediateWaypoints: [WaypointData] = [.mock,
                                                            .mock]
}
