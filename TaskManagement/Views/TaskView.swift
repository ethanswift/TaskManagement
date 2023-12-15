//
//  TaskView.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI
import CoreData

struct TaskView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    var retTask: Task
    @State private var thisTask: Task = Task()
    var body: some View {
        VStack {
            Spacer()
            Text(retTask.name!)
                .lineLimit(1)
                .backgrounded()
            Spacer()
            Text(retTask.title!)
                .lineLimit(3)
                .backgrounded()
            Spacer()
            HStack {
                Text(retTask.date!.description)
                    .backgrounded()
                Spacer()
                HStack {
                    Text("Completed:")
                        .backgrounded()
                        .padding(.trailing, 8)
                    ZStack {
                        Image(systemName: "circlebadge")
                            .scaleEffect(x: 2.5, y: 2.5)
                        Image(systemName: !thisTask.isComleted ? "" :  "checkmark")
                    }
                    .onTapGesture {
                        if thisTask.isComleted {
                            updateCompletedTask(task: thisTask,
                                                isCompleted: false) {
                            }
                            thisTask.isComleted = false
                        } else {
                            updateCompletedTask(task: thisTask,
                                                isCompleted: true) {
                            }
                            thisTask.isComleted = true
                        }
                    }
                }
            }
            Spacer()
        }
        .overlay(alignment: .topLeading) {
            Button { withAnimation { presentationMode.wrappedValue.dismiss() }
            } label: {
                Image(systemName: "xmark.circle")
                    .frame(width: 40,
                           height: 40)
                    .padding(.trailing, 50)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .padding(.horizontal, 48)
        .onAppear { thisTask = retTask }
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
        do {
            try context.save()
            completion()
        } catch {
            fatalError()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(retTask: Task())
    }
}
