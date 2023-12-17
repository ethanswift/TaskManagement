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
                    .mTxtFld(height: 60)
                TextField("Description",
                          text: $taskTitle)
                    .padding(.horizontal)
                    .mTxtFld(height: 60)
                    .padding(.top, 36)
                Spacer()
                Button {
                    let cdMng = CoreDataManager(context: context)
                    if taskName != "" || taskTitle != "" {
                        cdMng.addNewTask(taskName: taskName, taskTitle: taskTitle) {
                            showAddTask = false
                        }
                    }
                    showAddTask = false
                } label: { AddNewTaskBtn() }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) { ExitBtn(showAddTask: $showAddTask) }
        .ignoresSafeArea(.all)
    }
}

struct AddingTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddingTaskScreen(showAddTask: .constant(false))
    }
}
