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
import Utils

public protocol IRouteController: AnyObject {
    
    func getWaypoints() -> ResultPublisher<[WaypointData], RouteControllerError>
    func initiateStartWaypoint() -> ResultPublisher<WaypointData, RouteControllerError>
}

public enum RouteControllerError: Error {
    case unknown
}

public final class RouteController: IRouteController {
    
    private let routeRepository: IRouteRepository
    
    public init(routeRepository: IRouteRepository) {
        self.routeRepository = routeRepository
    }
    
    public func getWaypoints() -> ResultPublisher<[WaypointData], RouteControllerError> {
        Deferred {
            Future<[WaypointData], RouteControllerError> { [weak self] promise in
                guard let waypointData = self?.routeRepository.getAll() else {
                    promise(.failure(.unknown))
                    return
                }
                
                promise(.success(waypointData))
            }
        }
        .asResultPublisher()
    }
    
    public func initiateStartWaypoint() -> ResultPublisher<WaypointData, RouteControllerError> {
        // TODO: Connect to actual service
        Just(WaypointData(id: UUID().uuidString,
                          name: "Somewhere Unknownburg",
                          date: Date()))
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
    }
}
