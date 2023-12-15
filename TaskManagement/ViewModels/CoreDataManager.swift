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
        completion()
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
        completion()
    }
}
