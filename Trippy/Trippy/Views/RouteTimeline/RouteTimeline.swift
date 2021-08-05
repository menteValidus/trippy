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
import TrippyUI

struct RouteTimeline: View {
    
    private let defaultDayHeight: CGFloat = 240
    
    @ObservedObject var viewModel: RouteTimelineViewModel
    
    private var unevenDayColor: Color = Asset.Color.RouteTimeline.Background.primary.color
    private var evenDayColor: Color = Asset.Color.RouteTimeline.Background.secondary.color
    
    init(viewModel: RouteTimelineViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            Timeline(pointsData: $viewModel.pointsData)
                .frame(maxWidth: .infinity)
                .frame(height: defaultDayHeight * CGFloat(viewModel.numberOfAffectedDays))
                .background(TwoColorPatternBackground(numberOfRepetitions: viewModel.numberOfAffectedDays,
                                                      firstColor: unevenDayColor,
                                                      secondColor: evenDayColor))
        }
        .background(overallBackground()
                        .ignoresSafeArea())
    }
    
    private func overallBackground() -> Color {
        let isEven = viewModel.pointsData.count % 2 == 0
        
        return isEven ? unevenDayColor : evenDayColor
    }
}

struct RouteTimeline_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RouteTimelineViewModel(flow: .init())
        
        RouteTimeline(viewModel: vm)
            .previewLayout(.sizeThatFits)
    }
}
