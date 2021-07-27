//
//  WaypointData.swift
//  
//
//  Created by Denis Cherniy on 27.05.2021.
//

import Foundation

public struct WaypointData {
    
    public let id: String
    public let name: String
    public let date: Date
    
    public init(id: String,
                name: String,
                date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }
}

extension WaypointData: Equatable { }
