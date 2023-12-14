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
                  sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.date, ascending: false)]) var allTasks: FetchedResults<TaskEntity>
    @State private var showAddTask: Bool = false
    @State private var taskName: String = ""
    @State private var taskTitle: String = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(allTasks) { retTask in
                        NavigationLink {
                            VStack {
                                Spacer()
                                Text(retTask.name!)
                                  Spacer()
                                Text(retTask.title!)
                                Spacer()
                                HStack {
                                    Text(retTask.date!.description)
                                    Spacer()
                                    HStack {
                                        Text("Completed:  ")
                                            .padding(.trailing, 10)
                                        ZStack {
                                            Image(systemName: "circlebadge")
                                                .scaleEffect(x: 2.5, y: 2.5)
                                            Image(systemName: !retTask.completed ? "" :  "checkmark")
                                        }
                                        .onTapGesture {
                                            let thisTask = Task(id: retTask.id!, name: retTask.name, title: retTask.title, date: retTask.date, isComleted: retTask.completed)
                                            if retTask.completed {
                                                updateCompletedTask(task: thisTask, isCompleted: false) {
                                                }
                                            } else {
                                                updateCompletedTask(task: thisTask, isCompleted: true) {
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 48)
                        } label: {
                            VStack {
                                Text(retTask.name!)
                                    
                                Text(retTask.title!)
                                HStack {
                                    Text(retTask.date!.description)
                                    Spacer()
                                    HStack {
                                        Text("Completed:  ")
                                            .padding(.trailing, 10)
                                        ZStack {
                                            Image(systemName: "circlebadge")
                                                .scaleEffect(x: 2.5, y: 2.5)
                                            Image(systemName: !retTask.completed ? "" :  "checkmark")
                                        }
                                        .onTapGesture {
                                            let thisTask = Task(id: retTask.id!, name: retTask.name, title: retTask.title, date: retTask.date, isComleted: retTask.completed)
                                            if retTask.completed {
                                                updateCompletedTask(task: thisTask, isCompleted: false) {
                                                }
                                            } else {
                                                updateCompletedTask(task: thisTask, isCompleted: true) {
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
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
                })
                .listStyle(PlainListStyle())
                .fullScreenCover(isPresented: $showAddTask) {
                    ZStack {
                        VStack {
                            Spacer()
                            TextField("Title", text: $taskTitle)
                                .frame(width: UIScreen.main.bounds.width / 2,
                                       height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.3))
                                    )
                            Spacer()
                            TextField("Description", text: $taskName)
                                .frame(width: UIScreen.main.bounds.width / 2,
                                       height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.3))
                                    )
                            Spacer()
                            Button {
                                var dateformater = DateFormatter()
                                dateformater.dateStyle = .short
                                let newDate = dateformater.string(from: Date())
                                let newTask = Task(id: UUID().uuidString, name: taskName, title: taskTitle, date: newDate, isComleted: false)
                                self.addTask(task: newTask, completion: {
                                    showAddTask = false
                                })
                            } label: {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: UIScreen.main.bounds.width / 2,
                                           height: 50)
                                    .overlay(alignment: .center) {
                                        Text("Add New Task")
                                            .foregroundColor(.white)
                                    }
                            }
                            Spacer()
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.all)
                    .overlay(alignment: .topLeading) {
                        Button {
                            withAnimation {
                                showAddTask = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 50)
                        }

                        
                    }
                }
            }
        }
    }
    
//    private func move(from source: IndexSet, to destination: Int) {
//    }
    
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
    
    private func addTask(task: Task, completion: @escaping () -> Void) {
        print(task)
        let newTask = TaskEntity(context: context)
        newTask.id = UUID().uuidString
        newTask.name = task.name
        newTask.title = task.title
        newTask.date = task.date?.description
        newTask.completed = task.isComleted
        do {
            try context.save()
            print(newTask)
            completion()
        } catch {
            fatalError()
        }
    }
    
    private func updateCompletedTask(task: Task, isCompleted: Bool, completion: @escaping () -> Void) {
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
    
    private func removeTask(task: Task) {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchrequest.predicate = NSPredicate(format: "id == %@", task.id)
        if let results = try? context.fetch(fetchrequest), let object = results.first as? NSManagedObject {
            context.delete(object)
        }
        
        do {
            try context.save()
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
