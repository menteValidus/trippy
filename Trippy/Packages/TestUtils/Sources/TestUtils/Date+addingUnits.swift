//
//  Date+addingUnits.swift
//  
//
//  Created by Denis Cherniy on 06.08.2021.
//

import Foundation

public extension Date {
        
    static func date(daysAgo: Int, from date: Date) -> Date {
        let dateComponents = DateComponents(day: -daysAgo)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
    
    static func date(addingDays days: Int,
                     addingHours hours: Int,
                     from date: Date) -> Date {
        let dateComponents = DateComponents(day: days,
                                            hour: hours)
        
        return Calendar.current.date(byAdding: dateComponents, to: date) ?? Date()
    }
}
