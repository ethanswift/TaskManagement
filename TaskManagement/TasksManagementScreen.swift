//
//  TasksManagementScreen.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI
import CoreData

struct TasksManagementScreen: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: TaskEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.date, ascending: false)]) private var allTasks: FetchedResults<TaskEntity>
    @State private var showAddTask: Bool = false
    @State private var showCompletedTasks: Bool = false
    @State private var showNotCompletedTasks: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(allTasks) { retTask in
                        if showCompletedTasks == true && retTask.completed == true {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: {
                                TaskCell(retTask: newTask)
                            }
                        } else if showNotCompletedTasks == true && retTask.completed == false {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: {
                                TaskCell(retTask: newTask)
                            }
                        } else if showCompletedTasks == false && showNotCompletedTasks == false {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: {
                                TaskCell(retTask: newTask)
                            }
                        }
                    }.onDelete(perform: removeTaskAt)
                }
                .navigationBarTitle("To Do Tasks")
                .listStyle(.plain)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                showAddTask = true
                            }
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Menu {
                            Button {
                                showCompletedTasks = true
                                showNotCompletedTasks = false
                            } label: {
                                Label("Show Completed Tasks",
                                      image: "circle.grid.3x3.fill")
                            }
                            Button {
                                showNotCompletedTasks = true
                                showCompletedTasks = false
                            } label: {
                                Label("Show UnCompleted Tasks", image: "circle.grid.3x3.fill")
                            }
                            Button {
                                showCompletedTasks = false
                                showNotCompletedTasks = false
                            } label: {
                                Label("Show All Tasks",
                                      image: "circle.grid.3x3.fill")
                            }
                        } label: {
                            Image(systemName: "circle.grid.3x3.fill")
                        }
                    }
                })
                .listStyle(PlainListStyle())
                .fullScreenCover(isPresented: $showAddTask) {
                    AddingTaskScreen(showAddTask: $showAddTask)
                }
            }
        }
    }
    private func removeTaskAt(offset: IndexSet) {
        for index in offset {
            let task = allTasks[index]
            context.delete(task)
        }
        do {
            try context.save()
        
        } catch {
            fatalError()
        }
    }
    private func updateCompletedTask(task: Task,
                                     isCompleted: Bool,
                                     completion: @escaping () -> Void) {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchrequest.predicate = NSPredicate(format: "id == %@", task.id)
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

struct TasksManagementScreen_Previews: PreviewProvider {
    static var previews: some View {
        TasksManagementScreen()
    }
}
