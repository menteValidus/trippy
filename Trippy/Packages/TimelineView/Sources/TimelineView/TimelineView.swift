
import UIKit
import Stevia
import TrippyUI

public protocol TimelineViewDataSource: AnyObject {
    
    func timelineViewPointDataArray() -> [TimelinePointData]
}

public final class TimelineView: UIView {
    
    private let connectionViewsWidth: CGFloat = 2
    
    public weak var dataSource: TimelineViewDataSource?
    
    public var calendar: Calendar = .current
    
    public func reloadContent() {
        guard let pointsData = dataSource?.timelineViewPointDataArray(),
              let startDate = pointsData.first?.dateInterval.start,
              let endDate = pointsData.last?.dateInterval.end,
              startDate != endDate else {
            assertionFailure("Failed to configure starting values")
            return
        }
        
        createTimelineView(withData: pointsData,
                           insideOf: self)
    }
}

// MARK: - Views Creation

private extension TimelineView {
    
    func createTimelineView(withData pointsData: [TimelinePointData],
                            insideOf view: UIView) {
        guard let overallDuration = pointsData.computeCompletedDaysDurationInSecs(withCalendar: calendar) else {
            assertionFailure("Failed to compute overall duration of the path")
            return
        }
        
        var lastItemBottomAnchor: SteviaAttribute?
        var lastWaypointBottomAnchor: SteviaAttribute?
        
        for displaymentInfo in pointsData.convertedToDisplaymentInfo(usingCalendar: calendar) {
            switch displaymentInfo {
            // TODO: Remove code duplication
            case .emptySpace(let duration):
                let emptyView = createEmptySpaceView()
                subviews(emptyView)
                
                emptyView.Width == view.Width
                
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    emptyView.Top == lastItemBottomAnchor
                } else {
                    emptyView.Top == view.Top
                }
                
                let multiplier = CGFloat(duration) / CGFloat(overallDuration)
                emptyView.Height == view.Height * multiplier
                
                lastItemBottomAnchor = emptyView.Bottom
                
            case .waypoint(let data):
                let waypointView = createWaypointView(withData: data)
                subviews(waypointView)
                
                // TODO: Replace it with correct center anchor calculation
                let itemHorizontalOffset: CGFloat = 10
                waypointView.Trailing == view.Trailing - itemHorizontalOffset
                
                // TODO: Replace it with correct center anchor calculation
                let itemVerticalOffset: CGFloat = 15
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    waypointView.CenterY == lastItemBottomAnchor + itemVerticalOffset
                } else {
                    waypointView.CenterY == view.Top
                }
                
                if let lastWaypointBottomAnchor = lastWaypointBottomAnchor {
                    waypointView.Top >= lastWaypointBottomAnchor
                }
                
                lastWaypointBottomAnchor = waypointView.Bottom
                
            case .staying(let duration):
                let stayingView = createStayingView()
                subviews(stayingView)
                
                stayingView.Width == connectionViewsWidth
                stayingView.Trailing == view.Trailing - 141
                
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    stayingView.Top == lastItemBottomAnchor
                } else {
                    stayingView.Top == view.Top
                }
                
                let multiplier = CGFloat(duration) / CGFloat(overallDuration)
                stayingView.Height == view.Height * multiplier
                
                lastItemBottomAnchor = stayingView.Bottom
                
            case .inTransit(let duration):
                let inTransitView = createInTransitView()
                subviews(inTransitView)
                
                inTransitView.Width == connectionViewsWidth
                inTransitView.Trailing == view.Trailing - 141
                
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    inTransitView.Top == lastItemBottomAnchor
                } else {
                    inTransitView.Top == view.Top
                }
                
                let multiplier = CGFloat(duration) / CGFloat(overallDuration)
                inTransitView.Height == view.Height * multiplier
                
                lastItemBottomAnchor = inTransitView.Bottom
                
            }
        }
    }
    
    func createEmptySpaceView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func createWaypointView(withData data: WaypointData) -> UIView {
        let view = TimelinePoint(withData: data)
        
        return view
    }
    
    func createStayingView() -> UIView {
        let view = UIView()
        view.backgroundColor = Asset.Color.ConnectionLine.background.uiColor
        
        return view
    }
    
    func createInTransitView() -> DashedLine {
        let view = DashedLine()
        view.color = Asset.Color.ConnectionLine.background.uiColor
        
        return view
    }
}

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
