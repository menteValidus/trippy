//
//  WaypointDataMock.swift
//  
//
//  Created by Denis Cherniy on 27.05.2021.
//

import Domain
import Foundation

public extension WaypointData {
    
    static var mock: WaypointData {
        .init(id: UUID().uuidString,
              name: "Taganrog, Grecheskaya street, 104A",
              date: Date())
    }
}
