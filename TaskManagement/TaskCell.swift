//
//  TaskCell.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import SwiftUI

struct TaskCell: View {
    var task: Task
    var body: some View {
        VStack {
            Text(task.name!)
                
            Text(task.title!)
            HStack {
                Text(task.date!.description)
                Spacer()
                Image(systemName: task.isComleted ? "circle" : "xmark.filled")
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: Task())
    }
}
