//
//  HomeView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/14/23.
//

import SwiftUI

struct ReminderStatsValues {
    var todaysCount: Int = 0
}

struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults
                                .map { $0.remindersArray }
                                .reduce([], +)
        
        let todaysCount = remindersArray.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1: result
        }
        
        return ReminderStatsValues(todaysCount: todaysCount)
    }
}

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todaysCount)
                    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                    
                }.frame(maxWidth: .infinity)
                    .padding(5)
                    
                
                HStack {
                    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                    
                }.frame(maxWidth: .infinity)
                    .padding(5)
                
                Spacer()
                Text("My Lists")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                MyListsView(lists: myListResults)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
                }
               
        }
            
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
    }
}
