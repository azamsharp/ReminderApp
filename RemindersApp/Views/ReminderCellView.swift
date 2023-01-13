//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import SwiftUI
import CoreData

struct ReminderCellView: View {
    
    let reminder: Reminder
    let onReminderSelect: (Reminder) -> Void
    let onReminderCheckedChanged: (Reminder) -> Void
    let isSelected: Bool
    @Binding var showReminderDetail: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: reminder.isCompleted ? "circle.inset.filled": "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    onReminderCheckedChanged(reminder)
                }
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0: 0.0)
                .onTapGesture {
                    showReminderDetail = true
                }
        }.onTapGesture {
            onReminderSelect(reminder)
        }
    }
}


struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(reminder: PreviewData.reminder, onReminderSelect: { _ in }, onReminderCheckedChanged: { _ in }, isSelected: true, showReminderDetail: .constant(true))
    }
}
