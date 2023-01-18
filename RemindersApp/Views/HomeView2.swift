//
//  HomeView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/14/23.
//

import SwiftUI


struct HomeView2: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        
                        NavigationLink {
                            ReminderListView(request: ReminderService.remindersByStatType(statType: .today))
                                .navigationTitle("Today")
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todaysCount)
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
                    
                    Spacer()
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListsView(lists: myListResults)
                    
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
                .searchable(text: $search)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
                }
            
            
        }
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
            .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
    }
}
