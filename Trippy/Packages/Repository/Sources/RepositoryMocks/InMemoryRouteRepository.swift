//
//  InMemoryRouteRepository.swift
//  
//
//  Created by Denis Cherniy on 28.05.2021.
//

import Foundation
import Domain
import Combine
import Repository

public final class InMemoryRouteRepositoryMock: RouteRepository {
    
    public var waypointDataList: [WaypointData] = []
    
    public init() { }
    
    public func getAll() -> [WaypointData] {
        waypointDataList
    }
    
    public func insert(_ waypointData: WaypointData) -> AnyPublisher<Void, RepositoryError> {
        waypointDataList.append(waypointData)
        
        return Just(())
            .setFailureType(to: RepositoryError.self)
            .eraseToAnyPublisher()
    }
}