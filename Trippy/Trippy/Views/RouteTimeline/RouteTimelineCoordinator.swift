//
//  RouteTimelineCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 31.07.2021.
//

import Coordinator
import UIKit

protocol RouteTimelineCoordinatorDelegate: CoordinatorDelegate { }

final class RouteTimelineCoordinator: BaseCoordinator {
    
    private let presentingVC: UIViewController
    
    weak var delegate: CoordinatorDelegate?
    
    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }
    
    override func start() {
        let vc = UIViewController()
        present(vc, in: presentingVC)
    }
}
