//
//  ReminderStatsBuilder.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/15/23.
//

import Foundation
import SwiftUI 

struct ReminderStatsValues {
    var todaysCount: Int = 0
}

struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults
                                .map { $0.remindersArray }
                                .reduce([], +)
        
        let todaysCount = remindersArray.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1: result
        }
        
        return ReminderStatsValues(todaysCount: todaysCount)
    }
}
