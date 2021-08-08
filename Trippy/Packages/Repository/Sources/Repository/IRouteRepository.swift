//
//  RouteRepository.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Domain
import Combine

public enum RepositoryError: Error {
    
}

public protocol IRouteRepository: AnyObject {
    
    func getAll() -> [WaypointData]
    func insert(_ waypointData: WaypointData) -> AnyPublisher<Void, RepositoryError>
}
