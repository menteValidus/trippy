//
//  RouteCreationViewModelTests.swift
//  TrippyTests
//
//  Created by Denis Cherniy on 05.08.2021.
//

@testable import Trippy
import XCTest
import Repository

class RouteCreationViewModelTests: XCTestCase {

    var sut: RouteCreationViewModel!
    var inMemoryRepository: InMemoryRouteRepository!
    
    override func setUp() {
        inMemoryRepository = .init()
        sut = .init(flow: .init(),
                    routeRepository: inMemoryRepository)
    }
    
    override func tearDown() {
        inMemoryRepository = nil
        sut = nil
    }
    
    func testEmptyRepository() {
    }
}
