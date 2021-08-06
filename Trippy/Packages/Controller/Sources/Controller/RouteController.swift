//
//  RouteController.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Foundation
import Domain
import Combine
import Repository

public protocol IRouteController: AnyObject {
    
    func getSortedWaypoints() -> AnyPublisher<[WaypointData], RouteControllerError>
}

public enum RouteControllerError: Error {
    case unknown
}

public final class RouteController: IRouteController {
    
    private let routeRepository: RouteRepository
    
    public init(routeRepository: RouteRepository) {
        self.routeRepository = routeRepository
    }
    
    public func getSortedWaypoints() -> AnyPublisher<[WaypointData], RouteControllerError> {
        getWaypoints()
            .map { waypoints in
                waypoints.sorted { lhs, rhs in lhs < rhs}
            }
            .eraseToAnyPublisher()
    }
    
    private func getWaypoints() -> AnyPublisher<[WaypointData], RouteControllerError> {
        Deferred {
            Future<[WaypointData], RouteControllerError> { [weak self] promise in
                guard let waypointData = self?.routeRepository.getAll() else {
                    promise(.failure(.unknown))
                    return
                }
                
                promise(.success(waypointData))
            }
        }
        .eraseToAnyPublisher()
    }
}
