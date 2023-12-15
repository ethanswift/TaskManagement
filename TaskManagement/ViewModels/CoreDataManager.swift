//
//  CoreDataManager.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    var context: NSManagedObjectContext
//    static let shared = CoreDataManager()
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    func saveThis() {
        do {
            try context.save()
        } catch { fatalError() }
    }
    func addTask(task: Task,
                         completion: @escaping () -> Void) {
        let newTask = TaskEntity(context: context)
        newTask.id = UUID().uuidString
        newTask.name = task.name
        newTask.title = task.title
        newTask.date = task.date?.description
        newTask.completed = task.isComleted
        saveThis()
//        do {
//            try context.save()
//            completion()
//        } catch { fatalError() }
    }
    func updateCompletedTask(task: Task,
                                     isCompleted: Bool,
                                     completion: @escaping () -> Void) {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchrequest.predicate = NSPredicate(format: "id == %@",
                                             task.id)
        if let results = try? context.fetch(fetchrequest),
            let object = results.first as? NSManagedObject {
            object.setValue(isCompleted,
                            forKey: "completed")
        }
        saveThis()
//        do {
//            try context.save()
//            completion()
//        } catch { fatalError() }
    }

}

//class CoreDataManager: ObservableObject {
//    @Published var tasks: [Task] = []
//    static let sharedManager: CoreDataManager = CoreDataManager()
//    private init() {}
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "TaskManagement")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Unable to load persistent store")
//            }
//        }
//        return container
//    }()
//    func saveContext() {
//        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch let error as NSError {
//                print("Context didn't load")
//                print(error)
//                print(error.userInfo)
//                fatalError()
//            }
//        }
//    }
//}
