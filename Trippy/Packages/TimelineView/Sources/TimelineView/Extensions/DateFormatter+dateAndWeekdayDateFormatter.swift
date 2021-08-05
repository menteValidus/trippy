//
//  DateFormatter+dateAndWeekdayDateFormatter.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

// TODO: Move to the separate package and cover with tests

public extension DateFormatter {
    
    static var dateAndWeekdayDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM (EEEEEE)"
        dateFormatter.doesRelativeDateFormatting = false
        
        return dateFormatter
    }
}
