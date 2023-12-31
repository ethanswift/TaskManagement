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
                  sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.id,
                                                     ascending: true),
                                    NSSortDescriptor(keyPath: \TaskEntity.date, ascending: false)]) private var allTasks: FetchedResults<TaskEntity>
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
                            navigationLinks(newTask: newTask)
                        } else if showNotCompletedTasks && !retTask.completed {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            navigationLinks(newTask: newTask)
                        } else if !showCompletedTasks && !showNotCompletedTasks {
                            let newTask = Task(id: retTask.id!,
                                               name: retTask.name,
                                               title: retTask.title,
                                               date: retTask.date,
                                               isComleted: retTask.completed)
                            navigationLinks(newTask: newTask)
                        }
                    }.onDelete(perform: removeTaskAt)
                        .onMove(perform: move)
                }
                .navigationBarTitle("To Do Tasks")
                .listStyle(.plain)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) { addBtn }
                    ToolbarItem(placement: .automatic) { MenuView(showCompletedTasks: $showCompletedTasks, showNotCompletedTasks: $showNotCompletedTasks) }
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
    //MARK: - View Variables & Funcs
    private func navigationLinks(newTask: Task) -> some View {
        TaskCell(retTask: newTask)
            .overlay {
                NavigationLink { TaskView(retTask: newTask)
                } label: { EmptyView() }.opacity(0.0)
            }.listRowSeparator(.hidden)
    }
    var addBtn: some View {
        Button { showAddTask = true} label: {
            Image(systemName: "plus.circle").mImg(size: 25)
        }
    }
    //MARK: - Core Date & List Helper Methods
    private func move(from oldIndex: IndexSet,
                      to newIndex: Int) {
            var revisedItems: [TaskEntity] = allTasks.map({ $0 })
            revisedItems.move(fromOffsets: oldIndex,
                              toOffset: newIndex)
            for reverseIndex in stride(from: revisedItems.count - 1,
                                       through: 0,
                                       by: -1) {
                revisedItems[reverseIndex].id = String(Int16(exactly: reverseIndex)!)
                let cdMng = CoreDataManager(context: context)
                cdMng.saveThis()
            }
    }
    private func removeTaskAt(offset: IndexSet) {
        for index in offset {
            let task = allTasks[index]
            context.delete(task)
        }
        let cdMng = CoreDataManager(context: context)
        cdMng.saveThis()
    }
}

struct TasksManagementScreen_Previews: PreviewProvider {
    static var previews: some View {
        TasksManagementScreen()
    }
}
