//
//  InitialRouteCreationCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 24.05.2021.
//

import UIKit
import Coordinator

protocol InitialRouteCreationCoordinatorDelegate: CoordinatorDelegate {
    
}

final class InitialRouteCreationCoordinator: BaseCoordinator {
    weak var delegate: InitialRouteCreationCoordinatorDelegate?
    
    private var presentingViewController: UIViewController
    private var presentedViewController: UIViewController?
    
    init(presentingVC: UIViewController) {
        presentingViewController = presentingVC
    }
    
    override func start() {
        let vc = InitialRouteCreationViewController()
        present(vc, in: presentingViewController, animated: UIView.areAnimationsEnabled)
        
        presentedViewController = vc
    }
}
