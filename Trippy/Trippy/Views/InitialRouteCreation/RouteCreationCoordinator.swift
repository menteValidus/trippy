//
//  RouteCreationCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 24.05.2021.
//

import UIKit
import Coordinator

protocol RouteCreationCoordinatorDelegate: CoordinatorDelegate {
    
}

final class RouteCreationCoordinator: BaseCoordinator {
    weak var delegate: RouteCreationCoordinatorDelegate?
    
    private var presentingViewController: UIViewController
    private var presentedViewController: UIViewController?
    
    init(presentingVC: UIViewController) {
        presentingViewController = presentingVC
    }
    
    override func start() {
        let vc = RouteCreationViewController()
        vc.overrideUserInterfaceStyle = .dark
        present(vc, in: presentingViewController, animated: UIView.areAnimationsEnabled)
        
        presentedViewController = vc
    }
}
