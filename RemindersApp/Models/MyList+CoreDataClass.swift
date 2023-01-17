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

    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
    
}
