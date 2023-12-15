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
                .mFont(font: .title2, nLine: 1)
            Spacer()
            Text(retTask.title!)
                .mFont(font: .body, nLine: 3)
            Spacer()
            HStack {
                Text(retTask.date!.description)
                    .mFont(font: .footnote, nLine: 1)
                Spacer()
                dateComBar
            }
            Spacer()
        }
        .overlay(alignment: .topLeading) { exitBtn }
        .navigationTitle("")
        .navigationBarHidden(true)
        .padding(.horizontal, 48)
        .onAppear { thisTask = retTask }
    }
}

extension TaskView {
    //MARK: - View Variables & Funcs
    var dateComBar: some View {
        HStack {
            Text("Completed:")
                .mFont(font: .footnote, nLine: 1)
                .padding(.trailing, 8)
            ZStack {
                Image(systemName: "circlebadge")
                    .scaleEffect(x: 2.5, y: 2.5)
                Image(systemName: !thisTask.isComleted ? "" : "checkmark")
            }
            .onTapGesture {updateComplete()}
        }
    }
    var exitBtn: some View {
        Button { withAnimation { presentationMode.wrappedValue.dismiss() }
        } label: {
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 25,
                       height: 25)
                .padding(.trailing, 50)
        }

    }

    //MARK: - Core Date & List Helper Methods
    private func updateComplete() {
        let cdMng = CoreDataManager(context: context)
        if thisTask.isComleted {
            cdMng.updateCompletedTask(task: thisTask,
                                isCompleted: false) {
            }
            thisTask.isComleted = false
        } else {
            cdMng.updateCompletedTask(task: thisTask,
                                isCompleted: true) {
            }
            thisTask.isComleted = true
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(retTask: Task())
    }
}
