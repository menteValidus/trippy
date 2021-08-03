//
//  RouteTimeline.swift
//  Trippy
//
//  Created by Denis Cherniy on 31.07.2021.
//

import SwiftUI
import UIKit
import Stevia
import TimelineView

struct RouteTimeline: View {
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            Timeline()
        }
    }
}


protocol TimelineViewDataSource: AnyObject {
    
    func timelineViewPointDataArray() -> [TimelinePointData]
}

protocol TimelineViewDelegate: AnyObject {
    
    func timelineViewShouldTrimVerticalEdges() -> Bool
}

final class TimelineView: UIView {
    
//    private let defaultDayHeight: CGFloat = 240
    
    /*weak*/ var dataSource: TimelineViewDataSource?
    weak var delegate: TimelineViewDelegate?
    
    var calendar: Calendar = .current
//
//    private var dayHeight: CGFloat {
//        delegate?.timelineViewDayHeight() ?? defaultDayHeight
//    }
//
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = .red
//        Height == 100
////        commonInit()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
////        commonInit()
//    }
    
//    override func layoutSubviews() {
//        reloadContent()
//    }
    
    func reloadContent() {
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
    
//    private func getOverallContentHeight(forNumberOfDays days: Int) -> CGFloat {
//        CGFloat(days) * dayHeight
//    }
//
//    private func calculateDayHeight(forNumberOfDays days: Int) -> CGFloat {
//        self.frame.height / CGFloat(days)
//    }
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
                
                waypointView.Width == view.Width
                
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    waypointView.CenterY == lastItemBottomAnchor
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
                
                stayingView.Width == view.Width
                
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
                
                inTransitView.Width == view.Width
                
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
        view.backgroundColor = .black
        
        return view
    }
    
    func createWaypointView(withData data: WaypointData) -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.Height == 16
        view.Width == view.Height
        
        return view
    }
    
    func createStayingView() -> UIView {
        let view = UIView()
        view.backgroundColor = .blue
        
        return view
    }
    
    func createInTransitView() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        
        return view
    }
    
}

struct Timeline: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = TimelineTestVC()
        vc.dataSource = RouteTimelineCoordinator(presentingVC: UIViewController())
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct TimelineVCRep: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = TimelineTestVC()
        vc.dataSource = RouteTimelineCoordinator(presentingVC: UIViewController())
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct RouteTimeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
            .previewLayout(.sizeThatFits)
    }
}
