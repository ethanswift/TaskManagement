//
//  TaskCell.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI
import CoreData

struct TaskCell: View {
    @Environment(\.managedObjectContext) var context
    var retTask: Task
    @State private var thisTask: Task = Task()
    var body: some View {
        VStack {
            HStack {
                Text(retTask.name!)
                    .font(.headline)
                    .lineLimit(1)
                    .backgrounded()
                    .padding(.leading, 32)
                Spacer()
            }
            HStack {
                Text(retTask.title!)
                    .font(.title3)
                    .lineLimit(2)
                    .backgrounded()
                    .padding(.leading, 32)
                Spacer()
            }
            Spacer()
            HStack {
                Text(retTask.date!.description)
                    .font(.footnote)
                    .backgrounded()
                Spacer()
                HStack {
                    Text("Completed:")
                        .font(.footnote)
                        .backgrounded()
                        .padding(.trailing, 10)
                    ZStack {
                        Image(systemName: "circlebadge")
                            .scaleEffect(x: 2.5, y: 2.5)
                        Image(systemName: !retTask.isComleted ? "" :  "checkmark")
                    }.padding(.trailing, 10).padding(.bottom, 5)
                    .onTapGesture {
                        if thisTask.isComleted {
                            updateCompletedTask(task: thisTask,
                                                isCompleted: false) {
                                thisTask.isComleted = false
                            }
                        } else {
                            updateCompletedTask(task: thisTask,
                                                isCompleted: true) {
                                thisTask.isComleted = true
                            }
                        }
                    }
                }
            }
        }
        .background(content: { Color.blue.opacity(0.2) })
        .onAppear { thisTask = retTask }
    }
}

extension TaskCell {
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
        do {
            try context.save()
            completion()
        } catch { fatalError() }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(retTask: Task())
    }
}
