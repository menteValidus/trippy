//
//  BaseCoordinator.swift
//  
//
//  Created by Denis Cherniy on 23.05.2021.
//

import Foundation
import UIKit

// TODO: Add tests for uncovered parts

// It has to be successor of NSObject because some descestors
// might be delegates that require NSObject protocol conformance.
open class BaseCoordinator: NSObject, Coordinator, CoordinatorDelegate {
    internal var coordinators: [Coordinator] = []
    
    deinit {
        coordinators.forEach {
            remove(dependency: $0)
        }
    }

    open func start() {
        fatalError("Not implemented")
    }

    open func didEnterBackground() {
        coordinators.forEach {
            $0.didEnterBackground()
        }
    }

    open func willEnterForeground() {
        coordinators.forEach {
            $0.willEnterForeground()
        }
    }

    public func add(dependency coordinator: Coordinator) {
        coordinators.append(coordinator)
    }

    public func remove(dependency coordinator: Coordinator) {
        guard let index = coordinators.firstIndex(where: { $0 === coordinator }) else { return }

        coordinators.remove(at: index)
    }

    open func coordinatorFlowFinished(_ coordinator: Coordinator) {
        remove(dependency: coordinator)
    }

    public func present(_ viewController: UIViewController, in presentingVC: UIViewController, animated: Bool = UIView.areAnimationsEnabled) {
        if let navVC = presentingVC as? UINavigationController {
            navVC.pushViewController(viewController, animated: animated)
            return
        }

        if let navVC = presentingVC.navigationController, !(viewController is UINavigationController) {
            navVC.pushViewController(viewController, animated: animated)
        } else {
            presentingVC.present(viewController, animated: animated)
        }
    }

    public func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        if let navVC = viewController.navigationController {
            navVC.popViewController(animated: animated)
        } else {
            viewController.dismiss(animated: animated)
        }
    }
}
