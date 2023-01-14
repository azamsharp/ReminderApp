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
    
    // this can be moved into a separate class if necessary
    static private func scheduleNotification(reminder: Reminder) {
        
        let content = UNMutableNotificationContent()
        content.title = reminder.title ?? ""
        content.body = reminder.notes ?? ""
        
        // date components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.reminderDate ?? Date())
        
        if let reminderTime = reminder.reminderTime {
            let reminderTimeDateComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws {
       
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime: nil
        
        try save()
        
        // schedule a notification
        if editConfig.hasDate || editConfig.hasTime {
            // schedule a notification
            scheduleNotification(reminder: reminder)
        }
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
