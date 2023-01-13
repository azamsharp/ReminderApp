//
//  ReminderService.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import Foundation
import CoreData
import UIKit 

class ReminderService {
    
    static func save() throws {
        try CoreDataProvider.shared.viewContext.save()
    }
    
    static func updateReminder(currentReminder: Reminder, editConfig: ReminderEditConfig) throws {
        let reminderToUpdate = currentReminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        try save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: CoreDataProvider.shared.viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        
        let reminder = Reminder(context: CoreDataProvider.shared.viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
}
