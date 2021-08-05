//
//  Calendar+numberOfUnits.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

// TODO: Move it to the separate package Extensions and cover with tests
public extension Calendar {
    
    func numberOfDaysBetween(_ startDate: Date,
                             andIncluding endDate: Date) -> Int {
        return (numberOfDaysBetween(startDate, and: endDate) ?? 0) + 1
    }
}

extension Calendar {
    
    func numberOfDaysBetween(_ startDate: Date,
                             and endDate: Date) -> Int? {
        let fromDate = startOfDay(for: startDate)
        
        let toDate = startOfDay(for: endDate)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day
    }
    
    func numberOfSecondsBetween(_ startDate: Date,
                                and endDate: Date) -> Int? {
        let numberOfDays = dateComponents([.second], from: startDate, to: endDate)
        
        return numberOfDays.second
    }
    
    func numberOfSecondsSinceStartOfDay(forDate date: Date) -> Int? {
        let startOfDay = startOfDay(for: date)
        
        return numberOfSecondsBetween(startOfDay, and: date)
    }
    
    func numberOfSecondsTilEndOfDay(forDate date: Date) -> Int? {
        guard let nextDay = Date.nextDay(for: date,
                                         withCalendar: self) else { return nil }
        
        let endOfCurrentDay = startOfDay(for: nextDay)
        
        return numberOfSecondsBetween(date, and: endOfCurrentDay)
    }
}
