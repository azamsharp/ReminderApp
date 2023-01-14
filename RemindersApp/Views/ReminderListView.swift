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
    
    @State var delayCall: DispatchWorkItem?
    
    @FetchRequest
    private var reminders: FetchedResults<Reminder>
    
    init(myList: MyList) {
        
        self.myList = myList
        _reminders = FetchRequest(fetchRequest: myList.remindersByMyListRequest)
    }
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    private func delayCall(delay: Double, completion: @escaping () -> ()) {
        
        // cancel any existing call
        delayCall?.cancel()
        
        delayCall = DispatchWorkItem {
            completion()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: delayCall!)
        
    }
    
    private func reminderCheckedChanged(reminder: Reminder) {
        
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        
        do {
            try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {}
        
    }
    
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                            case .showDetail(let reminder):
                                selectedReminder = reminder
                            case .checkedChanged(let reminder):
                                reminderCheckedChanged(reminder: reminder)
                            case .select:
                                showReminderDetail = true
                        }
                    }
                    
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
            ReminderDetailView(reminder: Binding($selectedReminder)!)
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


