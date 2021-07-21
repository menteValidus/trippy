//
//  InMemoryRouteRepository.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Foundation
import Domain

public final class InMemoryRouteRepository: RouteRepository {
    
    public func getAll() -> [WaypointData] {
        []
    }
    
    public func insert(_ waypointData: WaypointData) {
        
    }
}
