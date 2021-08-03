//
//  RouteTimelineCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 31.07.2021.
//

import Coordinator
import UIKit
import SwiftUI

protocol RouteTimelineCoordinatorDelegate: CoordinatorDelegate { }

final class RouteTimelineCoordinator: BaseCoordinator {
    
    private let presentingVC: UIViewController
    
    weak var delegate: CoordinatorDelegate?
    
    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }
    
    override func start() {
        let vc = TimelineTestVC()
        vc.dataSource = self
//        let vc = UIHostingController(rootView: RouteTimeline())
        present(vc, in: presentingVC)
    }
}

import Stevia

final class TimelineTestVC: UIViewController {
    
    weak var dataSource: TimelineViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = TimelineView()
        view.dataSource = dataSource
        
        self.view.subviews(view)
        view.fillContainer()
        
        view.reloadContent()
    }
}

import TimelineView

extension RouteTimelineCoordinator: TimelineViewDataSource {
    private var date: Date { .init() }
    
    func timelineViewPointDataArray() -> [TimelinePointData] {
        [
            .init(dateInterval: .init(start: Date.date(daysAgo: 6, from: date),
                                      end: Date.date(daysAgo: 5, from: date)),
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
