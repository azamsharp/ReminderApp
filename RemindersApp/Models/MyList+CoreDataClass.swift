//
//  Room+CoreDataClass.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {

    // get the reminders that are not completed
    lazy var remindersByMyListRequest: NSFetchRequest<Reminder> = {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@", self)
        return request
    }()
    
}
