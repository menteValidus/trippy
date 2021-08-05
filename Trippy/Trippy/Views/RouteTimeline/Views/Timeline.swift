//
//  Timeline.swift
//  Trippy
//
//  Created by Denis Cherniy on 05.08.2021.
//

import SwiftUI
import TimelineView

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

struct Timeline_Previews: PreviewProvider {
    
    // TODO: Fix preview
    static var previews: some View {
        Timeline(pointsData: .constant([.init(dateInterval: .init(start: Date(),
                                                                  duration: 128),
                                              title: "Test")]))
            .previewLayout(.fixed(width: 260, height: 100))
    }
}
