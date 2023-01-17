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
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
    
}

struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults
                                .map { $0.remindersArray }
                                .reduce([], +)
        
        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        
        return ReminderStatsValues(todaysCount: todaysCount, scheduledCount: scheduledCount, allCount: allCount, completedCount: completedCount)
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1: result
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return (reminder.reminderDate != nil || reminder.reminderTime != nil) ? result + 1: result
        }
    }
    
}
