//
//  TimelinePieceType.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

enum TimelinePieceType {
    
    case emptySpace(duration: TimeInterval)
    case inTransit(duration: TimeInterval)
    case staying(duration: TimeInterval)
    case waypoint(data: TimelineWaypointData)
}

extension TimelinePieceType: Equatable {
    
    public static func == (lhs: TimelinePieceType, rhs: TimelinePieceType) -> Bool {
        switch (lhs, rhs) {
        case let (.emptySpace(lhs), .emptySpace(rhs)):
            return lhs == rhs
            
        case let (.inTransit(lhs), .inTransit(rhs)):
            return lhs == rhs
            
        case let (.staying(lhs), .staying(rhs)):
            return lhs == rhs
            
        case let (.waypoint(lhs), .waypoint(rhs)):
            return lhs == rhs
            
        default:
            return false
        }
    }
}
