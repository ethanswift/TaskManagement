//
//  AddingTaskScreen.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI

struct AddingTaskScreen: View {
    @Binding var showAddTask: Bool
    @Environment(\.managedObjectContext) var context
    @State private var taskName: String = ""
    @State private var taskTitle: String = ""
    var body: some View {
        ZStack {
            VStack {
                Text("Add A New Task")
                    .font(.title)
                    .padding(.top, 60)
                Spacer()
                TextField("Title", text: $taskName)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width / 2,
                           height: 60)
                    .backgrounded()
                TextField("Description",
                          text: $taskTitle)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width / 2,
                           height: 60)
                    .backgrounded()
                    .padding(.top, 36)
                Spacer()
                Button {
                    let dateformater = DateFormatter()
                    dateformater.dateStyle = .short
                    let newDate = dateformater.string(from: Date())
                    let newTask = Task(id: UUID().uuidString,
                                       name: taskName,
                                       title: taskTitle,
                                       date: newDate,
                                       isComleted: false)
                    self.addTask(task: newTask,
                                 completion: {
                        showAddTask = false
                    })
                } label: {
                    RoundedRectangle(cornerRadius: 10)
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
        .overlay(alignment: .topLeading) {
            Button {
                withAnimation {
                    showAddTask = false
                }
            } label: {
                Image(systemName: "xmark.circle")
                    .frame(width: 60,
                           height: 60)
                    .padding(.leading, 30)
                    .padding(.top, 30)
            }
        }
        .ignoresSafeArea(.all)
    }
    private func addTask(task: Task,
                         completion: @escaping () -> Void) {
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
}

struct AddingTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddingTaskScreen(showAddTask: .constant(false))
    }
}
