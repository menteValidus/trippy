//
//  WaypointData.swift
//  
//
//  Created by Denis Cherniy on 27.05.2021.
//

import Foundation

public struct WaypointData {
    public let name: String
    public let date: Date
    
    public init(name: String,
                date: Date) {
        self.name = name
        self.date = date
    }
}
