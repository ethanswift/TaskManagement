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
    func addNewTask(taskName: String, taskTitle: String, completion: @escaping () -> Void) {
        let dateformater = DateFormatter()
        dateformater.dateStyle = .short
        let newDate = dateformater.string(from: Date())
        let newTask = Task(id: UUID().uuidString,
                           name: taskName,
                           title: taskTitle,
                           date: newDate,
                           isComleted: false)
//        let cdMng = CoreDataManager(context: context)
        addTask(task: newTask,
                     completion: {})
        completion()
    }
    private func addTask(task: Task,
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
    func updateComlete(thisTask: Task, completion: @escaping () -> Void) {
        let cdMng = CoreDataManager(context: context)
        cdMng.updateCompletedTask(task: thisTask,
                                  isCompleted: !thisTask.isComleted) {
            completion()
        }

    }
    private func updateCompletedTask(task: Task,
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
