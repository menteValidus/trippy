//
//  RouteCreationViewModel.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import Foundation
import Utils
import Domain
import TimelineView

final class RouteTimelineViewModel: ViewModel {
    
    struct Flow { }
    
    private let flow: Flow
    
    @Published var pointsData: [TimelinePointData] = []
    
    init(flow: Flow) {
        self.flow = flow
        
        let start1 = Date.date(daysAgo: 6, from: Date())
        let end1 = Date.date(daysAgo: 5, from: Date())
        
        print("***", start1, end1)
        
        let start2 = Date.date(daysAgo: 3, from: Date())
        let end2 = Date.date(daysAgo: 2, from: Date())
        
        print("***", start2, end2)
        
        pointsData = [
            .init(dateInterval: .init(start: start1,
                                      end: end1),
                  title: "1"),
            .init(dateInterval: .init(start: start2,
                                      end: end2),
                  title: "1")
        ]
    }
}

private extension Date {
    
    static func date(daysAgo: Int, from date: Date) -> Date {
        let dateComponents = DateComponents(day: -daysAgo)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
}
