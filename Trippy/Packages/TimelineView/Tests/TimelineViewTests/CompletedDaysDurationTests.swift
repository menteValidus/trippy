import XCTest
@testable import TimelineView

final class CompletedDaysDurationTests: XCTestCase {
    
    var pointsData: [TimelinePointData] = []
    
    override func setUp() {
        pointsData = []
    }
    
    func testCompletedDaysDurationEmptyPointsData() {
        XCTAssertEqual(0, pointsData.computeCompletedDaysDurationInSecs(withCalendar: .current))
    }
    
    func testCompletedDaysDurationInOneDayInterval() {
        let currentDate = Date()
        pointsData.append(.init(dateInterval: .init(start: Date.date(daysAgo: 7,
                                                                     from: currentDate),
                                                    end: Date.date(daysAgo: 7,
                                                                   from: currentDate)),
                                title: ""))
        
        XCTAssertEqual(1 * 86400, pointsData.computeCompletedDaysDurationInSecs(withCalendar: .current))
    }
    
    func testCompletedDaysDurationInTwoDaysInterval() {
        let currentDate = Date()
        pointsData.append(.init(dateInterval: .init(start: Date.date(daysAgo: 7,
                                                                     from: currentDate),
                                                    end: Date.date(daysAgo: 6,
                                                                   from: currentDate)),
                                title: ""))
        
        XCTAssertEqual(2 * 86400, pointsData.computeCompletedDaysDurationInSecs(withCalendar: .current))
    }
    
    func testCompletedDaysDurationInThreedDaysInterval() {
        let currentDate = Date()
        pointsData.append(.init(dateInterval: .init(start: Date.date(daysAgo: 7,
                                                                     from: currentDate),
                                                    end: Date.date(daysAgo: 5,
                                                                   from: currentDate)),
                                title: ""))
        
        XCTAssertEqual(3 * 86400, pointsData.computeCompletedDaysDurationInSecs(withCalendar: .current))
    }
    
    func testCompletedDaysDurationWithSeveralPointsData() {
        let currentDate = Date()
        pointsData.append(.init(dateInterval: .init(start: Date.date(daysAgo: 7,
                                                                     from: currentDate),
                                                    end: Date.date(daysAgo: 5,
                                                                   from: currentDate)),
                                title: ""))
        pointsData.append(.init(dateInterval: .init(start: Date.date(daysAgo: 2,
                                                                     from: currentDate),
                                                    end: Date.date(daysAgo: 1,
                                                                   from: currentDate)),
                                title: ""))
        
        XCTAssertEqual(7 * 86400, pointsData.computeCompletedDaysDurationInSecs(withCalendar: .current))
    }
}

private extension Date {
    
    static func date(daysAgo: Int, from date: Date) -> Date {
        let dateComponents = DateComponents(day: -daysAgo)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
}
