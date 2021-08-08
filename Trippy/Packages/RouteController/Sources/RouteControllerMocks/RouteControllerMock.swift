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
import Utils

public final class RouteControllerMock: IRouteController {
    
    public lazy var getWaypointsPublisher: ResultPublisher<[WaypointData], RouteControllerError> = {
        Just([])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
    }()
    
    public lazy var addWaypointsPublisher: ResultPublisher<Void, RouteControllerError> = {
        Just(())
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
    }()
    
    public lazy var initiateStartWaypointPublisher: ResultPublisher<WaypointData, RouteControllerError> = {
        Just(.mock)
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
    }()
    
    public init() { }
    
    public func getWaypoints() -> ResultPublisher<[WaypointData], RouteControllerError> {
        getWaypointsPublisher
    }
    
    public func addWaypoint(waypointData: WaypointData) -> ResultPublisher<Void, RouteControllerError> {
        addWaypointsPublisher
    }
    
    public func initiateStartWaypoint() -> ResultPublisher<WaypointData, RouteControllerError> {
        initiateStartWaypointPublisher
    }
}
