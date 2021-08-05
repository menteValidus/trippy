@testable import Repository
import XCTest
import Domain
import DomainMocks
import Combine

final class RouteRepositoryTests: XCTestCase {
    
    var sut: InMemoryRouteRepository!
    var cancelBag: Set<AnyCancellable> = []
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        cancelBag.removeAll()
    }
    
    func testInsert() {
        let expectation = XCTestExpectation()
        let waypointData = WaypointData.mock
        sut.insert(waypointData)
            .sink { _ in }
                receiveValue: { _ in
                    expectation.fulfill()
                }
            .store(in: &cancelBag)

        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual([waypointData], sut.getAll())
    }
}
