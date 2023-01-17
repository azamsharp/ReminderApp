//
//  ReminderStatListView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/17/23.
//

import SwiftUI

struct ReminderStatListView: View {
    
    let statType: ReminderStatType
    
    @FetchRequest
    private var reminders: FetchedResults<Reminder>
    
    init(statType: ReminderStatType) {
        self.statType = statType
        _reminders = FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: statType))
    }
    
    var body: some View {
        List(reminders) { reminder in
            Text(reminder.title ?? "")
        }
    }
}

struct ReminderStatListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderStatListView(statType: .all)
    }
}
