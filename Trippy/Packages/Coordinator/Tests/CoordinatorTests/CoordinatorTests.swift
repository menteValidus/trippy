//
//  BaseCoordinatorTests.swift
//
//
//  Created by Denis Cherniy on 23.05.2021.
//

@testable import Coordinator
import XCTest

fileprivate class FakeCoordinator: BaseCoordinator {
    
    var didEnterBackgroundCalled: Bool = false
    var willEnterForegroundCalled: Bool = false

    override func didEnterBackground() {
        super.didEnterBackground()

        didEnterBackgroundCalled = true
    }

    override func willEnterForeground() {
        super.willEnterForeground()

        willEnterForegroundCalled = true
    }
}

class BaseCoordinatorTests: XCTestCase {
    
    var coordinator: BaseCoordinator!

    override func setUpWithError() throws {
        coordinator = BaseCoordinator()
    }

    func testAddDependency() throws {
        let newCoordinator = FakeCoordinator()

        coordinator.add(dependency: newCoordinator)

        XCTAssertEqual(coordinator.coordinators.count, 1)
    }

    func testRemoveDependency() throws {
        let newCoordinator1 = FakeCoordinator()
        let newCoordinator2 = FakeCoordinator()

        coordinator.add(dependency: newCoordinator1)
        coordinator.add(dependency: newCoordinator2)

        coordinator.remove(dependency: newCoordinator1)

        XCTAssertEqual(coordinator.coordinators.count, 1)
        XCTAssertTrue(coordinator.coordinators.first! === newCoordinator2)
    }

    func testDidEnterBackground() throws {
        let newCoordinator1 = FakeCoordinator()
        let newCoordinator2 = FakeCoordinator()

        coordinator.add(dependency: newCoordinator1)
        coordinator.add(dependency: newCoordinator2)

        coordinator.didEnterBackground()

        let result = coordinator.coordinators.allSatisfy { ($0 as! FakeCoordinator).didEnterBackgroundCalled }

        XCTAssertTrue(result)
    }

    func testWillEnterForeground() throws {
        let newCoordinator1 = FakeCoordinator()
        let newCoordinator2 = FakeCoordinator()

        coordinator.add(dependency: newCoordinator1)
        coordinator.add(dependency: newCoordinator2)

        coordinator.willEnterForeground()

        let result = coordinator.coordinators.allSatisfy { ($0 as! FakeCoordinator).willEnterForegroundCalled }

        XCTAssertTrue(result)
    }
}
