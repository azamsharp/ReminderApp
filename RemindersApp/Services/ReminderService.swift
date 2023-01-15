//
//  ReminderService.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import Foundation
import CoreData
import UIKit 

// Domain Service
class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func shouldSendNotificationForReminder(reminder: Reminder) -> Bool {
        reminder.reminderDate != nil || reminder.reminderTime != nil
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
       
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime: nil
        
        try save()
        return true
    }
    
    static func deleteReminder(reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func deleteReminder(_ reminder: Reminder) throws {
        CoreDataProvider.shared.viewContext.delete(reminder)
        try save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
}
