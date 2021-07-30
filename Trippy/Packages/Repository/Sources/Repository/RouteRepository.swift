//
//  RouteRepository.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Domain

public protocol RouteRepository: AnyObject {
    
    func getAll() -> [WaypointData]
    func insert(_ waypointData: WaypointData)
}
