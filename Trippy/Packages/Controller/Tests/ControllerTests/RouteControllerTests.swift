//
//  RouteControllerTests.swift
//
//
//  Created by Denis Cherniy on 28.05.2021.
//

import XCTest
@testable import Controller
import RepositoryMocks
import Combine
import Domain
import TestUtils

final class RouteControllerTests: XCTestCase {
    
    var sut: RouteController!
    var routeRepositoryMock: InMemoryRouteRepositoryMock!
    var cancelBag: Set<AnyCancellable> = []
    
    override func setUp() {
        routeRepositoryMock = .init()
        sut = .init(routeRepository: routeRepositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        routeRepositoryMock = nil
    }
    
    func testEmptyRepositoryIntegration() {
        let expectation = XCTestExpectation()
        
        sut.getSortedWaypoints()
            .sink { _ in
                
            } receiveValue: { data in
                guard data.isEmpty else {
                    XCTFail("Should be empty")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)

        wait(for: [expectation], timeout: 0.1)
    }
    
    func testNotSortedRepositoryIntegration() {
        let expectation = XCTestExpectation()
        
        let oldWaypoint = WaypointData(id: "1",
                                       name: "1",
                                       date: Date.date(daysAgo: 2, from: Date()))
        let newWaypoint = WaypointData(id: "2",
                                       name: "2",
                                       date: Date())
        let expectedData = [oldWaypoint, newWaypoint]
        let unorderedData = [newWaypoint, oldWaypoint]
        
        routeRepositoryMock.waypointDataList = unorderedData
        
        sut.getSortedWaypoints()
            .sink { _ in
                
            } receiveValue: { data in
                guard !data.isEmpty,
                      data == expectedData else {
                    XCTFail("Shouldn't be empty")
                    return
                }
                
                expectation.fulfill()
            }
            .store(in: &cancelBag)
        
        wait(for: [expectation], timeout: 0.1)
    }
}
