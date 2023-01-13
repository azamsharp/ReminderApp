//
//  ContentView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/8/23.
//

import SwiftUI
import CoreData

struct MyListsView: View {
    
    @State private var isPresented: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if myListResults.isEmpty {
                    Spacer()
                    Text("No reminders found.")
                } else {
                    List {
                        ForEach(myListResults) { myList in
                            NavigationLink(value: myList) {
                                MyListCellView(myList: myList)
                                    .font(.title3)
                            }
                            
                        }
                    }.scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }
            .navigationTitle("MyList")
            .navigationDestination(for: MyList.self, destination: { myList in
                ReminderListView(myList: myList)
            })
            
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        
        
    }
    
    struct MyListsView_Previews: PreviewProvider {
        static var previews: some View {
            MyListsView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
