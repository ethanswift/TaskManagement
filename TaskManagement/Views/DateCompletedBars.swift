//
//  DateCompletedBars.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/17/23.
//

import SwiftUI

struct DateCompletedBars: View {
    @Environment(\.managedObjectContext) var context
    var retTask: Task
    @Binding var thisTask: Task
    var body: some View {
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
                .onTapGesture {
                    let cdMng = CoreDataManager(context: context)
                    cdMng.updateComlete(thisTask: thisTask) {
                        thisTask.isComleted.toggle()
                    }
                }
            }
        }
    }
}

struct DateCompletedBars_Previews: PreviewProvider {
    static var previews: some View {
        DateCompletedBars(retTask: Task(), thisTask: .constant(Task()))
    }
}
