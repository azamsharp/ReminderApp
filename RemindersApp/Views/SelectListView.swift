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
                
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }
                   
                
                /*
                MyListCellView(myList: myList)
                    .font(.title3)
                    .onTapGesture {
                        self.selectedList = myList
                } */
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
