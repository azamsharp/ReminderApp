//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/8/23.
//

import SwiftUI
import UserNotifications

@main
struct RemindersAppApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permissed granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MyListsView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
