//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI

@main
struct TaskManagementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TasksManagementScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
