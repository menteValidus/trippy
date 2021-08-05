
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
        let view = TimelinePointView(withData: data)
        
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

