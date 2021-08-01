

import Foundation

public struct TimelinePointData {
    public let dateInterval: DateInterval
    public let title: String
}

private extension Int {
    
    private var secondsInDay: Int { 86400 }
    
    var daysToSeconds: Int {
        self * secondsInDay
    }
}

public enum TimelinePieceType {
    
    case inTransit(duration: TimeInterval)
    case staying(duration: TimeInterval)
    case waypoint(data: WaypointData)
}

extension TimelinePieceType: Equatable {
    
    public static func == (lhs: TimelinePieceType, rhs: TimelinePieceType) -> Bool {
        switch (lhs, rhs) {
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

public struct WaypointData {
    
    let date: Date
    let title: String?
    
    init(date: Date,
         title: String? = nil) {
        self.date = date
        self.title = title
    }
}

extension WaypointData: Equatable { }

public extension Array where Element == TimelinePointData {
    
    func computeCompletedDaysDurationInSecs(withCalendar calendar: Calendar) -> Int {
        guard let startDate = self.first?.dateInterval.start,
              let endDate = self.last?.dateInterval.end,
              let finalDate = Date.nextDay(for: endDate,
                                           withCalendar: calendar) else { return 0 }
        
        return calendar.numberOfDaysBetween(startDate, and: finalDate).daysToSeconds
    }
    
    func convertedToDisplaymentInfo() -> [TimelinePieceType] {
        guard !isEmpty else { return [] }
        
        var timelinePieceTypeArray: [TimelinePieceType] = []
        
        for index in 0..<count {
            let pointData = self[index]
            
            let startWaypoint = WaypointData(date: pointData.dateInterval.start,
                                             title: pointData.title)
            timelinePieceTypeArray.append(.waypoint(data: startWaypoint))
            
            let stayingDuration = pointData.dateInterval.duration
            timelinePieceTypeArray.append(.staying(duration: stayingDuration))
            
            let endWaypoint = WaypointData(date: pointData.dateInterval.end)
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
        
        return timelinePieceTypeArray
    }
}

private extension Calendar {
    
    func numberOfDaysBetween(_ from: Date,
                             and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}

private extension Date {
    
    static func nextDay(for date: Date,
                        withCalendar calendar: Calendar) -> Date? {
        let dateComponents = DateComponents(day: 1)
        
        return calendar.date(byAdding: dateComponents, to: date)
    }
}
