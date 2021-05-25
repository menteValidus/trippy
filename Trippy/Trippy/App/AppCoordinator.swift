//
//  AppCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 24.05.2021.
//

import Coordinator
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
    }
}

private extension AppCoordinator {
    
    func navigateToInitialScreen() {
        guard let presentingVC = presentedViewController else { return }
        
        let coordinator = InitialRouteCreationCoordinator(presentingVC: presentingVC)
        coordinator.delegate = self
        coordinator.start()
        
        add(dependency: coordinator)
    }
}

extension AppCoordinator: InitialRouteCreationCoordinatorDelegate { }
