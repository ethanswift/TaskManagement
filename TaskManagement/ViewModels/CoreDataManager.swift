//
//  CoreDataManager.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: ObservableObject {
    @Published var tasks: [Task] = []
    static let sharedManager: CoreDataManager = CoreDataManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskManagement")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent store")
            }
        }
        return container
    }()
    func saveContext() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Context didn't load")
                print(error)
                print(error.userInfo)
                fatalError()
            }
        }
    }
}
