//
//  TimelinePoint.swift
//  Trippy
//
//  Created by Denis Cherniy on 03.08.2021.
//

import UIKit
import TimelineView
import TrippyUI
import Stevia

final class TimelinePoint: UIView {
    
    private let fontSize: CGFloat = 24
    
    private var data: WaypointData = .init(date: Date(),
                                           title: nil)
    
    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    init(withData data: WaypointData) {
        self.data = data
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
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
        
        waypointMarkView.Width == 22
        waypointMarkView.Height == waypointMarkView.Width
        
        
//        waypointMarkView.LastBaseline == dateLabel.FirstBaseline
        c
        waypointMarkView.Top == dateLabel.Top
        waypointMarkView.Trailing == dateLabel.Leading - 15
        waypointMarkView.Leading == Leading
    }
}

// MARK: - Views Creation

private extension TimelinePoint {
    
    func createDateLabel() -> UILabel {
        let dateLabel = UILabel()
        dateLabel.text = "15.08 (вс)"
        dateLabel.font = .systemFont(ofSize: fontSize,
                                     weight: .regular)
        // TODO: Change it to the some other separate color
        dateLabel.textColor = Asset.Color.ConnectionLine.background.uiColor
        
        return dateLabel
    }
    
    func createTimeLabel() -> UILabel {
        let timeLabel = UILabel()
        timeLabel.text = "6:00"
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
    
    func makeUIView(context: Context) -> some UIView {
        TimelinePoint()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    static var previews: some View {
        Self()
            .background(Asset.Color.Background.secondary.color)
            .previewLayout(.fixed(width: 200,
                                  height: 60))
    }
}

#endif
