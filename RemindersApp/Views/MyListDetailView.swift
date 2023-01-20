//
//  MyListDetailView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/20/23.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    @State private var title: String = ""
    @State private var openAddReminder: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminderResults)
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        } .alert("New Reminder", isPresented: $openAddReminder, actions: {
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
    }
}

struct MyListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyListDetailView(myList: PreviewData.myList)
    }
}
