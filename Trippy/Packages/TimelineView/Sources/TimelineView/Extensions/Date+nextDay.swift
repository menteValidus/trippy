//
//  Date+nextDay.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

extension Date {
    
    static func nextDay(for date: Date,
                        withCalendar calendar: Calendar) -> Date? {
        let dateComponents = DateComponents(day: 1)
        
        return calendar.date(byAdding: dateComponents, to: date)
    }
}
