//
//  WaypointData.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

struct WaypointData {
    
    public let date: Date
    public let title: String?
    
    public init(date: Date,
         title: String? = nil) {
        self.date = date
        self.title = title
    }
}

extension WaypointData: Equatable { }
