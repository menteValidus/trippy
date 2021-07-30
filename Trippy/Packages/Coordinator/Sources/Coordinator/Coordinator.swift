//
//  Coordinator.swift
//
//
//  Created by Denis Cherniy on 23.05.2021.
//

import Foundation

public protocol Coordinator: AnyObject {
    func start()

    func didEnterBackground()
    func willEnterForeground()

    func add(dependency coordinator: Coordinator)
    func remove(dependency coordinator: Coordinator)
}

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorFlowFinished(_ coordinator: Coordinator)
}
