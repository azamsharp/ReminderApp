//
//  PreviewData.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import Foundation
import CoreData

class PreviewData {
    
    static var reminder: Reminder {
        let viewContext = CoreDataProvider.shared.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Reminder(context: viewContext) 
    }
    
    static var allMyLists: NSFetchRequest<MyList> {
        let request = MyList.fetchRequest()
        return request 
    }
    
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList() 
    }
    
}
