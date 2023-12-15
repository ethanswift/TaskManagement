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
                    .mFont(font: .headline, nLine: 1)
                    .padding(.leading, 32)
                Spacer()
            }
            HStack {
                Text(retTask.title!)
                    .mFont(font: .title3, nLine: 3)
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
                .mFont(font: .footnote, nLine: 1)
            Spacer()
            HStack {
                Text("Completed:")
                    .mFont(font: .footnote, nLine: 1)
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
