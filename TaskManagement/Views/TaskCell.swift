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
            LeftAlignedText(pad: 32, text: retTask.name, font: .headline, nLine: 1)
            LeftAlignedText(pad: 32, text: retTask.title, font: .title3, nLine: 1)
                .bgwithColor(color: .blue).padding(.horizontal, 8)
            Spacer()
            DateCompletedBars(retTask: retTask, thisTask: $thisTask)
        }
        .bgwithColor(color: .green)
        .onAppear { thisTask = retTask }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(retTask: Task())
    }
}
