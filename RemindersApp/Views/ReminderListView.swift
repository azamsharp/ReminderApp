//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import SwiftUI
import CoreData

struct ReminderListView: View {
    
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    @FetchRequest
    private var reminders: FetchedResults<Reminder>
    
    init(myList: MyList) {
        
        self.myList = myList
        _reminders = FetchRequest(fetchRequest: myList.remindersByMyListRequest)
    }
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    private func reminderCheckedChanged(reminder: Reminder) {
        
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        do {
            try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, onReminderSelect: { reminder in
                        selectedReminder = reminder
                    }, onReminderCheckedChanged: reminderCheckedChanged, isSelected: selectedReminder?.objectID == reminder.objectID, showReminderDetail: $showReminderDetail)
                }.onDelete(perform: deleteReminder)
            }
                
                Spacer()
                
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Button("New Reminder") {
                        openAddReminder = true
                    }
                }.foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .sheet(isPresented: $showReminderDetail, content: {
                if let reminder = selectedReminder {
                    ReminderDetailView(reminder: reminder, editConfig: ReminderEditConfig(reminder: reminder))
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        selectedReminder = nil
                    }.opacity(selectedReminder != nil ? 1.0: 0.0)
                }
            })
            .alert("New Reminder", isPresented: $openAddReminder, actions: {
                TextField("", text: $title)
                Button("Cancel", role: .cancel) { }
                Button("Done") {
                    if isFormValid {
                        do {
                            try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            })
            
            .navigationTitle(myList.name)
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct ReminderListView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                ReminderListView(myList: PreviewData.myList)
            }
        }
    }
    
    
