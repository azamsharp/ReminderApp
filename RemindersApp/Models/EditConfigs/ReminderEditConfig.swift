//
//  ReminderEditConfig.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date = Date()
    var reminderTime: Date = Date()
    
    init() { }
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate ?? Date()
        reminderTime = reminder.reminderTime ?? Date()
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
