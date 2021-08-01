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

//struct RouteTimeline: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}


protocol TimelineViewDataSource: AnyObject {
    
    func timelineViewPointDataArray() -> [TimelinePointData]
}

protocol TimelineViewDelegate: AnyObject {
    
    func timelineViewShouldTrimVerticalEdges() -> Bool
}

final class TimelineView: UIView {
    
//    private let defaultDayHeight: CGFloat = 240
    
    weak var dataSource: TimelineViewDataSource?
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
    
    private func reloadContent() {
        guard let pointsData = dataSource?.timelineViewPointDataArray(),
              let startDate = pointsData.first?.dateInterval.start,
              let endDate = pointsData.last?.dateInterval.end,
              startDate != endDate else {
            assertionFailure("Failed to configure starting values")
            return
        }
        
        
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
        let overallDuration = pointsData.computeCompletedDaysDurationInSecs(withCalendar: calendar)
        var lastItemBottomAnchor: SteviaAttribute?
        
        for displaymentInfo in pointsData.convertedToDisplaymentInfo() {
            switch displaymentInfo {
            case .waypoint(let data):
                let waypointView = createWaypointView(withData: data)
                
                if let lastItemBottomAnchor = lastItemBottomAnchor {
                    waypointView.CenterY == lastItemBottomAnchor
                } else {
                    
                }
                break
                
            case .staying(let duration):
                break
                
            case .inTransit(let duration):
                break
                
            }
        }
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

struct Timeline: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        TimelineView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

struct RouteTimeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
            .previewLayout(.sizeThatFits)
    }
}
