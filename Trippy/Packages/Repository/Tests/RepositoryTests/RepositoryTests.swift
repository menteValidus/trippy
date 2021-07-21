    @testable import Repository
    import XCTest
    import Domain

    final class RepositoryTests: XCTestCase {
        
        var sut = InMemoryRouteRepository()
        
        func testInsert() {
            sut.insert(WaypointData.mock)
        }
    }
