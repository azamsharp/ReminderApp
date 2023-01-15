//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/10/23.
//

import SwiftUI



struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title) // Changing the config 
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate, displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select Date", selection: $editConfig.reminderTime, displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectedList: $reminder.list)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.list!.name)
                            }
                        }

                    }
                    
                }.listStyle(.insetGrouped)
                
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if isFormValid {
                            // save the new reminder
                            do {
                                let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                                
                                if updated {
                                    if ReminderService.shouldSendNotificationForReminder(reminder: reminder) {
                                        let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                        NotificationManager.scheduleNotification(userData: userData)
                                    }
                                }
                                
                                // send the notification
                                dismiss()
                            } catch {
                                print(error)
                            }
                        }
                    }.disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderDetailView(reminder: .constant(PreviewData.reminder))
                .environment(\.colorScheme, .dark)
        }
    }
}
