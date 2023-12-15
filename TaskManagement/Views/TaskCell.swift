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
            dateComBars
        }
        .background(content: { Color.blue.opacity(0.2) })
        .onAppear { thisTask = retTask }
    }
}

extension TaskCell {
    //MARK: - View Variables & Funcs
    var dateComBars: some View {
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
                .onTapGesture { updateComplete() }
            }
        }
    }
    //MARK: - Core Date & List Helper Methods
    private func updateComplete() {
        let cdMng = CoreDataManager(context: context)
        if thisTask.isComleted {
            cdMng.updateCompletedTask(task: thisTask,
                                isCompleted: false) {
                thisTask.isComleted = false
            }
        } else {
            cdMng.updateCompletedTask(task: thisTask,
                                isCompleted: true) {
                thisTask.isComleted = true
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(retTask: Task())
    }
}
