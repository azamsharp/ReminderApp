//
//  SelectListView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/13/23.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListsFetchResults) { myList in
            HStack {
                MyListCellView(myList: myList)
                    .font(.title3)
                    .onTapGesture {
                        selectedList = myList
                }
                Spacer()
                
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
                
            }.contentShape(Rectangle())
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("List")
                    .font(.headline)
            }
        }
    }
}

struct SelectListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectListView(selectedList: .constant(PreviewData.myList))
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
