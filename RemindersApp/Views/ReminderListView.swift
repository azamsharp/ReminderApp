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
    
    var body: some View {
        VStack {
            
            List(reminders) { reminder in
                HStack {
                    Image(systemName: reminder.isCompleted ? "circle.inset.filled": "circle")
                        .font(.title2)
                        .opacity(0.4)
                        .onTapGesture {
                            var editConfig = ReminderEditConfig(reminder: reminder)
                            editConfig.isCompleted = !reminder.isCompleted
                            //let editConfig = ReminderEditConfig(isCompleted: !reminder.isCompleted)
                            do {
                                try ReminderService.updateReminder(currentReminder: reminder, editConfig: editConfig)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    Text(reminder.title ?? "")
                    Spacer()
                    Image(systemName: "info.circle.fill")
                        .opacity(selectedReminder?.objectID == reminder.objectID ? 1.0: 0.0)
                        .onTapGesture {
                            showReminderDetail = true
                        }
                }.onTapGesture {
                    selectedReminder = reminder
                }
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


