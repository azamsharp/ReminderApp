//
//  ReminderService.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/9/23.
//

import Foundation
import CoreData
import UIKit 

class ReminderService {
    
    private var viewContext: NSManagedObjectContext
    
    static let shared = ReminderService()
    
    private init() {
        self.viewContext = CoreDataProvider.shared.viewContext
    }
    
    func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try viewContext.save()
    }
}
