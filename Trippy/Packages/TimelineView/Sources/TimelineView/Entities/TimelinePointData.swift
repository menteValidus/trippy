//
//  TimelinePointData.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

public struct TimelinePointData {
    
    public let dateInterval: DateInterval
    public let title: String
    
    public init(dateInterval: DateInterval,
                title: String) {
        self.dateInterval = dateInterval
        self.title = title
    }
}
