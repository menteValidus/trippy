//
//  InMemoryRouteRepository.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Foundation
import Domain

public final class InMemoryRouteRepository: RouteRepository {
    
    var waypointDataList: [WaypointData] = []
    
    public init() { }
    
    public func getAll() -> [WaypointData] {
        waypointDataList
    }
    
    public func insert(_ waypointData: WaypointData) {
        waypointDataList.append(waypointData)
    }
}
