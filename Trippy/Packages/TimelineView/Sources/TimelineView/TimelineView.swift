

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

private extension Int {
    
    private var secondsInDay: Int { 86400 }
    
    var daysToSeconds: Int {
        self * secondsInDay
    }
}

public enum TimelinePieceType {
    
    case emptySpace(duration: TimeInterval)
    case inTransit(duration: TimeInterval)
    case staying(duration: TimeInterval)
    case waypoint(data: WaypointData)
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

public struct WaypointData {
    
    public let date: Date
    public let title: String?
    
    public init(date: Date,
         title: String? = nil) {
        self.date = date
        self.title = title
    }
}

extension WaypointData: Equatable { }

public extension Array where Element == TimelinePointData {
    
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

// TODO: Move it to the separate package Extensions and cover with tests
public extension Calendar {
    
    func numberOfDaysBetween(_ startDate: Date,
                             andIncluding endDate: Date) -> Int {
        return (numberOfDaysBetween(startDate, and: endDate) ?? 0) + 1
    }
}

private extension Calendar {
    
    func numberOfDaysBetween(_ startDate: Date,
                             and endDate: Date) -> Int? {
        let fromDate = startOfDay(for: startDate)
        
        let toDate = startOfDay(for: endDate)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day
    }
    
    func numberOfSecondsBetween(_ startDate: Date,
                                and endDate: Date) -> Int? {
        let numberOfDays = dateComponents([.second], from: startDate, to: endDate)
        
        return numberOfDays.second
    }
    
    func numberOfSecondsSinceStartOfDay(forDate date: Date) -> Int? {
        let startOfDay = startOfDay(for: date)
        
        return numberOfSecondsBetween(startOfDay, and: date)
    }
    
    func numberOfSecondsTilEndOfDay(forDate date: Date) -> Int? {
        guard let nextDay = Date.nextDay(for: date,
                                         withCalendar: self) else { return nil }
        
        let endOfCurrentDay = startOfDay(for: nextDay)
        
        return numberOfSecondsBetween(date, and: endOfCurrentDay)
    }
}

private extension Date {
    
    static func nextDay(for date: Date,
                        withCalendar calendar: Calendar) -> Date? {
        let dateComponents = DateComponents(day: 1)
        
        return calendar.date(byAdding: dateComponents, to: date)
    }
}
