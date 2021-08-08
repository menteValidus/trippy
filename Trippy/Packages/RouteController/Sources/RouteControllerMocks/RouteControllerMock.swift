//
//  RouteControllerMock.swift
//  
//
//  Created by Denis Cherniy on 08.08.2021.
//

import RouteController
import Domain
import DomainMocks
import Combine

public final class RouteControllerMock: IRouteController {
    
    public lazy var getWaypointsPublisher: AnyPublisher<[WaypointData], RouteControllerError> = {
        Just([])
            .setFailureType(to: RouteControllerError.self)
            .eraseToAnyPublisher()
    }()
    
    public lazy var initiateStartWaypointPublisher: AnyPublisher<WaypointData, RouteControllerError> = {
        Just(.mock)
            .setFailureType(to: RouteControllerError.self)
            .eraseToAnyPublisher()
    }()
    
    public func getWaypoints() -> AnyPublisher<[WaypointData], RouteControllerError> {
        getWaypointsPublisher
    }
    
    public func initiateStartWaypoint() -> AnyPublisher<WaypointData, RouteControllerError> {
        initiateStartWaypointPublisher
    }
}
