//
//  DateFormatter+shortTimeFormatter.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Foundation

// TODO: Move to the separate package and cover with tests
public extension DateFormatter {
    
    static var shortTimeFormatter: DateFormatter {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        return timeFormatter
    }
}
