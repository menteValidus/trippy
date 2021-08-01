//
//  File.swift
//  
//
//  Created by Denis Cherniy on 01.08.2021.
//

import XCTest
@testable import TimelineView

final class DisplaymentInfoConversionTests: XCTestCase {
    
    var pointsData: [TimelinePointData] = []
    
    var testDate: Date {
        Calendar.current.date(from: DateComponents(year: 2021, month: 8, day: 1, hour: 6))!
    }
    
    override func setUp() {
        pointsData = []
    }
    
    func testEmptyPointsDataConvertedToDisplaymentInfo() {
        XCTAssertEqual([TimelinePieceType](), pointsData.convertedToDisplaymentInfo())
    }
    
    func testOneStayingConvertedToDisplaymentInfo() {
        let startDate = testDate
        let endDate = Date.date(addingDays: 0,
                                addingHours: 6,
                                from: testDate)

        let expectedResult: [TimelinePieceType] = [
            .waypoint(data: .init(date: startDate, title: "")),
            .staying(duration: 6 * 3600),
            .waypoint(data: .init(date: endDate))]
        
        pointsData.append(.init(dateInterval: .init(start: startDate,
                                                    end: endDate),
                                title: ""))
        
        XCTAssertEqual(expectedResult, pointsData.convertedToDisplaymentInfo())
    }
    
    func testTwoStayingsConvertedToDisplaymentInfo() {
        let title1 = "First one"
        let startDate1 = testDate
        let endDate1 = Date.date(addingDays: 0,
                                addingHours: 6,
                                from: testDate)
        
        pointsData.append(.init(dateInterval: .init(start: startDate1,
                                                    end: endDate1),
                                title: title1))
        
        let title2 = "Second one"
        let startDate2 = Date.date(addingDays: 1,
                                   addingHours: 0,
                                   from: testDate)
        let endDate2 = Date.date(addingDays: 1,
                                 addingHours: 7,
                                 from: testDate)
        
        
        pointsData.append(.init(dateInterval: .init(start: startDate2,
                                                    end: endDate2),
                                title: title2))

        let expectedResult: [TimelinePieceType] = [
            .waypoint(data: .init(date: startDate1,
                                  title: title1)),
            .staying(duration: 6 * 3600),
            .waypoint(data: .init(date: endDate1)),
            .inTransit(duration: 18 * 3600),
            .waypoint(data: .init(date: startDate2,
                                  title: title2)),
            .staying(duration: 7 * 3600),
            .waypoint(data: .init(date: endDate2))]
        
        
        XCTAssertEqual(expectedResult, pointsData.convertedToDisplaymentInfo())
    }
}

private extension Date {
    
    static func date(addingDays days: Int,
                     addingHours hours: Int,
                     from date: Date) -> Date {
        let dateComponents = DateComponents(day: days,
                                            hour: hours)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
}

