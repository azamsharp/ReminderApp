//
//  HomeView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/14/23.
//

import SwiftUI

enum ReminderStatType {
    case today
    case all
    case scheduled
    case completed
}

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    @State private var search: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    NavigationLink {
                        ReminderStatListView(statType: .today)
                    } label: {
                        ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todaysCount)
                    }
                    
                    ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduledCount, iconColor: .red)
                    
                }.frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 10)
                
                HStack {
                    NavigationLink {
                        ReminderStatListView(statType: .all)
                    } label: {
                        ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .secondary)
                    }
                    
                    NavigationLink {
                        ReminderStatListView(statType: .completed)
                    } label: {
                        ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                    }

                    
                }.frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 10)
                  
                Spacer()
                
                Text("My Lists")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                MyListsView(lists: myListResults)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
