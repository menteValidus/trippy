//
//  Array+TimelinePointDataConversions.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

extension Array where Element == TimelinePointData {
    
    func computeCompletedDaysDurationInSecs(withCalendar calendar: Calendar) -> Int? {
        guard let startDate = self.first?.dateInterval.start,
              let endDate = self.last?.dateInterval.end,
              let finalDate = Date.nextDay(for: endDate,
                                           withCalendar: calendar) else { return 0 }
        
        return calendar.numberOfDaysBetween(startDate, and: finalDate)?.daysToSeconds
    }
    
    func convertedToDisplaymentInfo(usingCalendar calendar: Calendar) -> [TimelinePieceType] {
        guard !isEmpty else { return [] }
        
        var timelinePieceTypeArray: [TimelinePieceType] = []
        
        for index in 0..<count {
            let pointData = self[index]
            
            let startWaypoint = TimelineWaypointData(date: pointData.dateInterval.start,
                                             title: pointData.title)
            timelinePieceTypeArray.append(.waypoint(data: startWaypoint))
            
            let stayingDuration = pointData.dateInterval.duration
            timelinePieceTypeArray.append(.staying(duration: stayingDuration))
            
            let endWaypoint = TimelineWaypointData(date: pointData.dateInterval.end)
            timelinePieceTypeArray.append(.waypoint(data: endWaypoint))
            
            let nextIndex = index + 1
            
            guard nextIndex < count else {
                continue
            }
            let nextPointData = self[nextIndex]
            let inTransitInterval = DateInterval(start: pointData.dateInterval.end,
                                                 end: nextPointData.dateInterval.start)
            
            timelinePieceTypeArray.append(.inTransit(duration: inTransitInterval.duration))
        }
        
        if let startDate = first?.dateInterval.start,
           let secondsSinceStartOfDay = calendar.numberOfSecondsSinceStartOfDay(forDate: startDate),
           secondsSinceStartOfDay > 0 {
            timelinePieceTypeArray.insert(.emptySpace(duration: TimeInterval(secondsSinceStartOfDay)),
                                          at: 0)
        }
        
        if let endDate = last?.dateInterval.end,
           let secondsTillEndOfDay = calendar.numberOfSecondsTilEndOfDay(forDate: endDate),
           secondsTillEndOfDay > 0 {
            timelinePieceTypeArray.append(.emptySpace(duration: TimeInterval(secondsTillEndOfDay)))
        }
        
        return timelinePieceTypeArray
    }
}
