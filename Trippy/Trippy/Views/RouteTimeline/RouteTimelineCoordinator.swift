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
        let vm = RouteTimelineViewModel(flow: .init())
        let view = RouteTimeline(viewModel: vm)
            .navigationBarHidden(true)
        let vc = UIHostingController(rootView: view)
        present(vc, in: presentingVC)
    }
}
