//
//  Int+secondsInDay.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

extension Int {
    
    private var secondsInDay: Int { 86400 }
    
    var daysToSeconds: Int {
        self * secondsInDay
    }
}
