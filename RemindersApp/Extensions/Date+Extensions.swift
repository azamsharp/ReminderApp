//
//  Date+Extensions.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
}
