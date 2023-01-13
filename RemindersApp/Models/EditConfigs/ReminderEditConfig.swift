//
//  ReminderEditConfig.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String = ""
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var selectedDate: Date?
    var selectedTime: Date?
    
    init() { }
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes ?? ""
        isCompleted = reminder.isCompleted
        selectedDate = reminder.reminderDate
        selectedTime = reminder.reminderTime
    }
}
