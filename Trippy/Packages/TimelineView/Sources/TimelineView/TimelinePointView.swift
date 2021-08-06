//
//  TimelinePointView.swift
//  Trippy
//
//  Created by Denis Cherniy on 03.08.2021.
//

import UIKit
import TrippyUI
import Stevia

final class TimelinePointView: UIView {
    
    // MARK: - Constants
    
    private let fontSize: CGFloat = 24
    private let waypointMarkDiameter: CGFloat = 22
    private let itemsSpacing: CGFloat = 15
    
    // MARK: -
    
    private var data: TimelineWaypointData = .init(date: Date(),
                                           title: "Taganrog")
    
    var dateFormatter: DateFormatter = DateFormatter.dateAndWeekdayDateFormatter
    
    var timeFormatter: DateFormatter = DateFormatter.shortTimeFormatter
    
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
    
    init(withData data: TimelineWaypointData) {
        self.data = data
        
        super.init(frame: .zero)
        
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    // TODO: Break into several separate methods
    private func configureView() {
        let dateLabel = createDateLabel()
        
        subviews(dateLabel)
        
        dateLabel.Trailing == Trailing
        dateLabel.Top == Top
        
        let timeLabel = createTimeLabel()
        
        subviews(timeLabel)
        
        timeLabel.Leading == dateLabel.Leading
        timeLabel.Top == dateLabel.Bottom
        timeLabel.Bottom == Bottom
        
        let waypointMarkView = createWaypointMarkView()
        
        subviews(waypointMarkView)
        
        waypointMarkView.Width == waypointMarkDiameter
        waypointMarkView.Height == waypointMarkView.Width
        
        waypointMarkView.Bottom == dateLabel.LastBaseline
        waypointMarkView.Trailing == dateLabel.Leading - itemsSpacing
        
        
        let leadingAnchorAttribute: SteviaAttribute
        if let titleLabel = createTitleLabel() {
            subviews(titleLabel)
            
            titleLabel.Leading == Leading
            titleLabel.Top == Top
            leadingAnchorAttribute = titleLabel.Trailing
        } else {
            leadingAnchorAttribute = Leading
        }
        
        waypointMarkView.Leading == leadingAnchorAttribute + itemsSpacing
    }
}

// MARK: - Views Creation

private extension TimelinePointView {
    
    func createTitleLabel() -> UILabel? {
        guard let title = data.title else { return nil }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: fontSize,
                                     weight: .regular)
        // TODO: Change it to the some other separate color
        titleLabel.textColor = Asset.Color.ConnectionLine.background.uiColor
        
        return titleLabel
    }
    
    func createDateLabel() -> UILabel {
        let dateLabel = UILabel()
        dateLabel.text = dateFormatter.string(from: data.date)
        dateLabel.font = .systemFont(ofSize: fontSize,
                                     weight: .regular)
        // TODO: Change it to the some other separate color
        dateLabel.textColor = Asset.Color.ConnectionLine.background.uiColor
        
        return dateLabel
    }
    
    func createTimeLabel() -> UILabel {
        let timeLabel = UILabel()
        timeLabel.text = timeFormatter.string(from: data.date)
        timeLabel.font = .systemFont(ofSize: fontSize,
                                     weight: .thin)
        // TODO: Change it to the some other separate color
        timeLabel.textColor = Asset.Color.ConnectionLine.background.uiColor
        
        return timeLabel
    }
    
    func createWaypointMarkView() -> CircleView {
        let circleView = CircleView()
        circleView.backgroundColor = Asset.Color.ConnectionLine.background.uiColor

        return circleView
    }
}

#if DEBUG

import SwiftUI

struct TimelinePoint_Previews: PreviewProvider, UIViewRepresentable {
    
    let data: TimelineWaypointData
    
    func makeUIView(context: Context) -> some UIView {
        TimelinePointView(withData: data)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    static var previews: some View {
        Group {
            Self(data: .init(date: Date(),
                             title: "Taganrog"))
            Self(data: .init(date: Date(),
                             title: nil))
        }
        .background(Asset.Color.RouteTimeline.Background.primary.color)
        .previewLayout(.fixed(width: 260,
                              height: 60))
    }
}

#endif
