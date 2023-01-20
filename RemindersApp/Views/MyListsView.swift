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
    @Environment(\.colorScheme) var colorScheme
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack
        {
                if myLists.isEmpty {
                    Spacer()
                    Text("No reminders found.")
                } else {
                    
                    ForEach(myLists) { myList in
                        NavigationLink(value: myList) {
                            VStack {
                                MyListCellView(myList: myList)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading], 10)
                                    .font(.title3)
                                    .foregroundColor(colorScheme == .dark ? Color.offWhite: Color.darkGray)
                                Divider()
                            }
                           
                        }.listRowBackground(colorScheme == .dark ? Color.darkGray: Color.offWhite)
                        
                    }

                        .scrollContentBackground(.hidden)
                        .navigationDestination(for: MyList.self, destination: { myList in
                            
                            MyListDetailView(myList: myList)
                                .navigationBarTitle(myList.name)
                        })
                }
                
                Spacer()
        }
    }
    
    /*
    struct MyListsView_Previews: PreviewProvider {
        
        static var previews: some View {
            
            let request = MyList.fetchRequest()
            request.sortDescriptors = []
            let myLists = try! request.execute()
            
            return MyListsView(myListResults: FetchedResults(myLists))
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    } */
    
    
}
