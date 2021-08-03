//
//  AppCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 24.05.2021.
//

import Coordinator
import TrippyUI
import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    private var presentedViewController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let vc = StyledNavigationController()
        window.rootViewController = vc
        presentedViewController = vc
        
        navigateToInitialScreen()
//        navigateToRouteTimelineScreen()
    }
}

private extension AppCoordinator {
    
    func navigateToInitialScreen() {
        guard let presentingVC = presentedViewController else { return }
        
        let coordinator = RouteCreationCoordinator(presentingVC: presentingVC)
        coordinator.delegate = self
        coordinator.start()
        
        add(dependency: coordinator)
    }
    
    func navigateToRouteTimelineScreen() {
        guard let presentingVC = presentedViewController else { return }
        
        let coordinator = RouteTimelineCoordinator(presentingVC: presentingVC)
        coordinator.delegate = self
        coordinator.start()
        
        add(dependency: coordinator)
    }
}

extension AppCoordinator: RouteCreationCoordinatorDelegate { }

extension AppCoordinator: RouteTimelineCoordinatorDelegate { }
