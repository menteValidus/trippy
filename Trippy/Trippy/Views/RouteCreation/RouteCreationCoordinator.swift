//
//  RouteCreationCoordinator.swift
//  Trippy
//
//  Created by Denis Cherniy on 24.05.2021.
//

import UIKit
import SwiftUI
import Coordinator
import Repository
import RouteController

protocol RouteCreationCoordinatorDelegate: CoordinatorDelegate { }

final class RouteCreationCoordinator: BaseCoordinator {
    weak var delegate: RouteCreationCoordinatorDelegate?
    
    private var presentingViewController: UIViewController
    private var presentedViewController: UIViewController?
    
    init(presentingVC: UIViewController) {
        presentingViewController = presentingVC
    }
    
    override func start() {
        guard let routeRepository = DependencyInjector.shared.resolve(IRouteRepository.self),
              let routeController = DependencyInjector.shared.resolve(IRouteController.self) else {
            assertionFailure("Failed to resolve dependencies")
            return
        }
        
        let vm = RouteCreationViewModel(flow: .init(addWaypoint: addWaypoint,
                                                    proceed: navigateToTheRouteTimeline),
                                        routeRepository: routeRepository,
                                        routeController: routeController)
        let vc = UIHostingController(rootView: RouteCreation(viewModel: vm))
        vc.overrideUserInterfaceStyle = .dark
        
        present(vc, in: presentingViewController, animated: UIView.areAnimationsEnabled)
        presentedViewController = vc
    }
}

private extension RouteCreationCoordinator {
    
    func addWaypoint() {
        
    }
    
    func navigateToTheRouteTimeline() {
        guard let presentedVC = presentedViewController else {
            assertionFailure("Presented VC is nil")
            return
        }
        let coordinator = RouteTimelineCoordinator(presentingVC: presentedVC)
        coordinator.delegate = self
        coordinator.start()
        
        add(dependency: coordinator)
    }
}

extension RouteCreationCoordinator: RouteTimelineCoordinatorDelegate { }
