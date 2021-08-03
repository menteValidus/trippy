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
    
    private let defaultDayHeight: CGFloat = 240
    
    @ObservedObject var viewModel: RouteTimelineViewModel
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            Timeline(pointsData: $viewModel.pointsData)
                .frame(maxWidth: .infinity)
                .frame(height: defaultDayHeight * CGFloat(viewModel.pointsData.count))
        }
    }
}


protocol TimelineViewDataSource: AnyObject {
    
    func timelineViewPointDataArray() -> [TimelinePointData]
}

//protocol TimelineViewDelegate: AnyObject {
//
//    func timelineViewShouldTrimVerticalEdges() -> Bool
//}

final class TimelineView: UIView {
    
    
    weak var dataSource: TimelineViewDataSource?
//    weak var delegate: TimelineViewDelegate?
    
    var calendar: Calendar = .current
    
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
                waypointView.Height == 10
                
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

// TOD: Place in separate file

struct Timeline: UIViewRepresentable {
    
    typealias UIViewType = TimelineView
    
    @Binding var pointsData: [TimelinePointData]
    
    class Coordinator: NSObject, TimelineViewDataSource {
        
        var pointsData: [TimelinePointData] = []
        
        func timelineViewPointDataArray() -> [TimelinePointData] {
            pointsData
        }
    }
    
    func makeUIView(context: Context) -> TimelineView {
        let view = TimelineView()
        view.dataSource = context.coordinator
        
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.pointsData = pointsData
        uiView.reloadContent()
    }
}

// TODO: REMOVE

private extension Date {
    
    static func date(daysAgo: Int, from date: Date) -> Date {
        let dateComponents = DateComponents(day: -daysAgo)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
}

struct RouteTimeline_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RouteTimelineViewModel(flow: .init())
        
        RouteTimeline(viewModel: vm)
            .previewLayout(.sizeThatFits)
    }
}
