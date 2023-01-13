//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/10/23.
//

import SwiftUI



struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let reminder: Reminder
    @State var editConfig: ReminderEditConfig
    
    init(reminder: Reminder, editConfig: ReminderEditConfig = ReminderEditConfig()) {
        self.reminder = reminder
        self._editConfig = State(wrappedValue: editConfig)
    }
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select Date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        
                    }
                }.listStyle(.insetGrouped)
                
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
                                try ReminderService.updateReminder(currentReminder: reminder, editConfig: editConfig)
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
            ReminderDetailView(reminder: PreviewData.reminder, editConfig: ReminderEditConfig())
                .environment(\.colorScheme, .dark)
        }
    }
}
