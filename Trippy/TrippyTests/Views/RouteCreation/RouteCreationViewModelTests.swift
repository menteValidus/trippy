//
//  RouteCreationViewModelTests.swift
//  TrippyTests
//
//  Created by Denis Cherniy on 05.08.2021.
//

@testable import Trippy
import XCTest
import RepositoryMocks
import Combine
import Domain
import DomainMocks
import RouteController
import RouteControllerMocks

class RouteCreationViewModelTests: XCTestCase {

    var sut: RouteCreationViewModel!
    var routeController: RouteControllerMock!
    
    var cancelBag: Set<AnyCancellable> = []
    
    override func setUp() {
        routeController = .init()
        sut = .init(flow: .init(),
                    routeController: routeController)
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = []
    }
}

// MARK: Initialization Tests

extension RouteCreationViewModelTests {
    
    func testEmptyRepositoryStartWaypointNotSet() {
        let expectation = XCTestExpectation()
        
        routeController.getWaypointsPublisher = Just([])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        let expectedStartWaypoint = WaypointData(id: UUID().uuidString,
                                                 name: "City",
                                                 date: Date())
        routeController.initiateStartWaypointPublisher = Just(expectedStartWaypoint)
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        sut.$startWaypoint
            .dropFirst()
            .sink { data in
                guard data == expectedStartWaypoint else {
                    XCTFail("Should be nil")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testEmptyRepositoryEndWaypointNotSet() {
        let expectation = XCTestExpectation()
        
        routeController.getWaypointsPublisher = Just([])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        let expectedEndWaypoint = WaypointData(id: UUID().uuidString,
                                                 name: "City",
                                                 date: Date())
        routeController.initiateStartWaypointPublisher = Just(expectedEndWaypoint)
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        sut.$endWaypoint
            .dropFirst()
            .sink { data in
                guard data == expectedEndWaypoint else {
                    XCTFail("Should be nil")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testEmptyRepositoryIntermediateWaypointNotSet() {
        let expectation = XCTestExpectation()
        routeController.getWaypointsPublisher = Just([])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        sut.$intermediateWaypoints
            .dropFirst()
            .sink { data in
                guard data.isEmpty else {
                    XCTFail("Should be empty")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testTwoItemsRepositoryIntermediateWaypointNotSet() {
        let expectation = XCTestExpectation()
        routeController.getWaypointsPublisher = Just([.mock, .mock])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        sut.$intermediateWaypoints
            .dropFirst()
            .sink { data in
                guard data.isEmpty else {
                    XCTFail("Should be nil")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testTwoItemsRepositoryCornerWaypointsSet() {
        let startWaypointExpectation = XCTestExpectation()
        let endWaypointExpectation = XCTestExpectation()
        
        let startWaypoint = WaypointData.mock
        let endWaypoint = WaypointData.mock
        routeController.getWaypointsPublisher = Just([startWaypoint, endWaypoint])
            .setFailureType(to: RouteControllerError.self)
            .asResultPublisher()
        
        sut.$startWaypoint
            .dropFirst()
            .sink { data in
                guard data == startWaypoint else {
                    XCTFail("Should be equal")
                    return
                }
                
                startWaypointExpectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.$endWaypoint
            .dropFirst()
            .sink { data in
                guard data == endWaypoint else {
                    XCTFail("Should be equal")
                    return
                }
                
                endWaypointExpectation.fulfill()
            }
            .store(in: &cancelBag)
        
        sut.loadData()
        wait(for: [startWaypointExpectation,
                   endWaypointExpectation],
             timeout: 0.1)
    }
}
