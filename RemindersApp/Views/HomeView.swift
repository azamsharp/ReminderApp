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
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        
                        NavigationLink {
                            ReminderListView(request: ReminderService.remindersByStatType(statType: .today))
                                .navigationTitle("Today")
                        } label: {
                            ReminderStatsView(icon: Constants1.Icons.calendar.rawValue, title: "Today", count: reminderStatsValues.todaysCount)
                        }
                        
                        NavigationLink {
                            ReminderListView(request: ReminderService.remindersByStatType(statType: .scheduled))
                                .navigationTitle("Scheduled")
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduledCount, iconColor: .red)
                        }
                        
                    }.frame(maxWidth: .infinity)
                        .padding([.leading, .trailing], 10)
                    
                    HStack {
                        NavigationLink {
                            
                            ReminderListView(request: ReminderService.remindersByStatType(statType: .all))
                                .navigationTitle("All")
                            
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .secondary)
                        }
                        
                        NavigationLink {
                            
                            ReminderListView(request: ReminderService.remindersByStatType(statType: .completed))
                                .navigationTitle("Completed")
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                        }
                        
                        
                    }.frame(maxWidth: .infinity)
                        .padding([.leading, .trailing], 10)
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListsView(myLists: myListResults)
                }
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
                
            }
            .sheet(isPresented: $isPresented, content: {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch  {
                            print(error.localizedDescription)
                        }
                    }
                }
            })
            .listStyle(.plain)
            .onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true: false
            })
            .overlay(alignment: .center, content: {
                ReminderListView(request: ReminderService.getRemindersBySearchTerm(search))
                    .opacity(searching ? 1.0: 0.0)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            
            .navigationTitle("Reminders")
        }.searchable(text: $search)
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
    
}
