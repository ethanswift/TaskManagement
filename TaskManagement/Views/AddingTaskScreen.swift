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
                TextField("Title",
                          text: $taskName)
                    .padding(.horizontal)
                    .frame(width: Cons.sW / 2,
                           height: 60)
                    .backgrounded()
                TextField("Description",
                          text: $taskTitle)
                    .padding(.horizontal)
                    .frame(width: Cons.sW / 2,
                           height: 60)
                    .backgrounded()
                    .padding(.top, 36)
                Spacer()
                Button { addNewTask()
                } label: { addNewTaskBtn }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) { exitBtn }
        .ignoresSafeArea(.all)
    }
}

extension AddingTaskScreen {
    //MARK: - View Variables & Funcs
    var addNewTaskBtn: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width / 2,
                   height: 50)
            .overlay(alignment: .center) {
                Text("Add New Task")
                    .foregroundColor(.white)
            }
    }
    var exitBtn: some View {
        Button {
            withAnimation { showAddTask = false }
        } label: {
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 25,
                       height: 25)
                .padding(.leading, 30)
                .padding(.top, 30)
        }
    }
    //MARK: - Core Date & List Helper Methods
    private func addNewTask() {
        let dateformater = DateFormatter()
        dateformater.dateStyle = .short
        let newDate = dateformater.string(from: Date())
        let newTask = Task(id: UUID().uuidString,
                           name: taskName,
                           title: taskTitle,
                           date: newDate,
                           isComleted: false)
        let cdMng = CoreDataManager(context: context)
        cdMng.addTask(task: newTask,
                     completion: { showAddTask = false })
    }
}

struct AddingTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddingTaskScreen(showAddTask: .constant(false))
    }
}
