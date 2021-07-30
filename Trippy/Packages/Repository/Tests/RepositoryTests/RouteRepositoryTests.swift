@testable import Repository
import XCTest
import Domain
import DomainMocks

final class RouteRepositoryTests: XCTestCase {
    
    var sut: InMemoryRouteRepository!
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInsert() {
        let waypointData = WaypointData.mock
        sut.insert(waypointData)
        
        XCTAssertEqual([waypointData], sut.getAll())
    }
}
