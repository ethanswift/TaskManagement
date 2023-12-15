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
                        if showCompletedTasks && retTask.completed {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: { TaskCell(retTask: newTask) }
                        } else if showNotCompletedTasks && !retTask.completed {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: { TaskCell(retTask: newTask) }
                        } else if !showCompletedTasks && !showNotCompletedTasks {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            NavigationLink {
                                TaskView(retTask: newTask)
                            } label: { TaskCell(retTask: newTask) }
                        }
                    }.onDelete(perform: removeTaskAt)
                        .onMove(perform: move)
                }
                .navigationBarTitle("To Do Tasks")
                .listStyle(.plain)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { showAddTask = true} label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Menu {
                            Button {
                                showCompletedTasks = true
                                showNotCompletedTasks = false
                            } label: { Text("Completed Tasks") }
                            Button {
                                showNotCompletedTasks = true
                                showCompletedTasks = false
                            } label: { Text("Uncompleted Tasks") }
                            Button {
                                showCompletedTasks = false
                                showNotCompletedTasks = false
                            } label: { Text("All Tasks") }
                        } label: { Image(systemName: "line.3.horizontal.decrease") }
                    }
                })
                .listStyle(PlainListStyle())
                .fullScreenCover(isPresented: $showAddTask) {
                    AddingTaskScreen(showAddTask: $showAddTask)
                }
            }
        }
    }
}

extension TasksManagementScreen {
    private func move(from oldIndex: IndexSet,
                      to newIndex: Int) {
        context.perform {
            var revisedItems: [TaskEntity] = allTasks.map({ $0 })
            revisedItems.move(fromOffsets: oldIndex,
                              toOffset: newIndex)
            for reverseIndex in stride(from: revisedItems.count - 1,
                                       through: 0,
                                       by: -1) {
                revisedItems[reverseIndex].id = String(Int64(exactly: reverseIndex)!)
            }
            try? context.save()
        }
    }
    private func removeTaskAt(offset: IndexSet) {
        for index in offset {
            let task = allTasks[index]
            context.delete(task)
        }
        saveThis()
    }
    private func saveThis() {
        do {
            try context.save()
        } catch { fatalError() }
    }
}

struct TasksManagementScreen_Previews: PreviewProvider {
    static var previews: some View {
        TasksManagementScreen()
    }
}
