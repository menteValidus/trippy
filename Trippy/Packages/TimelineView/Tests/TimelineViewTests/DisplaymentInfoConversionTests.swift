//
//  File.swift
//  
//
//  Created by Denis Cherniy on 01.08.2021.
//

import XCTest
@testable import TimelineView
import TestUtils

final class DisplaymentInfoConversionTests: XCTestCase {
    
    private let secsInHour: TimeInterval = 3600
    
    var pointsData: [TimelinePointData] = []
    var testDate: Date {
        Calendar.current.date(from: DateComponents(year: 2021, month: 8, day: 1, hour: 0))!
    }
    
    override func setUp() {
        pointsData = []
    }
    
    func testEmptyPointsDataConvertedToDisplaymentInfo() {
        XCTAssertEqual([TimelinePieceType](), pointsData.convertedToDisplaymentInfo(usingCalendar: .current))
    }
    
    func testOneStayingConvertedToDisplaymentInfoAtStartOfDay() {
        let startDate = testDate
        let endDate = Date.date(addingDays: 0,
                                addingHours: 6,
                                from: testDate)

        let expectedResult: [TimelinePieceType] = [
            .waypoint(data: .init(date: startDate,
                                  title: "")),
            .staying(duration: 6 * secsInHour),
            .waypoint(data: .init(date: endDate)),
            .emptySpace(duration: 18 * secsInHour)
        ]
        
        pointsData.append(.init(dateInterval: .init(start: startDate,
                                                    end: endDate),
                                title: ""))
        
        XCTAssertEqual(expectedResult, pointsData.convertedToDisplaymentInfo(usingCalendar: .current))
    }
    
    func testOneStayingConvertedToDisplaymentInfo() {
        let startDate = Date.date(addingDays: 0,
                                  addingHours: 2,
                                  from: testDate)
        let endDate = Date.date(addingDays: 0,
                                addingHours: 6,
                                from: testDate)

        let expectedResult: [TimelinePieceType] = [
            .emptySpace(duration: 2 * secsInHour),
            .waypoint(data: .init(date: startDate,
                                  title: "")),
            .staying(duration: 4 * secsInHour),
            .waypoint(data: .init(date: endDate)),
            .emptySpace(duration: 18 * secsInHour)
        ]
        
        pointsData.append(.init(dateInterval: .init(start: startDate,
                                                    end: endDate),
                                title: ""))
        
        XCTAssertEqual(expectedResult, pointsData.convertedToDisplaymentInfo(usingCalendar: .current))
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
            .staying(duration: 6 * secsInHour),
            .waypoint(data: .init(date: endDate1)),
            .inTransit(duration: 18 * secsInHour),
            .waypoint(data: .init(date: startDate2,
                                  title: title2)),
            .staying(duration: 7 * secsInHour),
            .waypoint(data: .init(date: endDate2)),
            .emptySpace(duration: 17 * secsInHour)
        ]
        
        
        XCTAssertEqual(expectedResult, pointsData.convertedToDisplaymentInfo(usingCalendar: .current))
    }
}
