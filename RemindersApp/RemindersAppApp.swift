//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/8/23.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    var body: some Scene {
        WindowGroup {
            MyListsView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
