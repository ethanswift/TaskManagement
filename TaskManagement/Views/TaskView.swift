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
            LeftAlignedText(pad: 32, text: retTask.name, font: .headline, nLine: 1)
                .frame(height: 100)
            LeftAlignedText(pad: 32, text: retTask.title, font: .title3, nLine: 3)
                .frame(height: Cons.sH / 3)
                .bgwithColor(color: .green)
                .padding(.horizontal, 16)
//            Spacer()
            DateCompletedBars(retTask: retTask, thisTask: $thisTask)
            Spacer()
        }
        .bgwithColor(color: .blue)
        .overlay(alignment: .topLeading) { exitBtn.offset(x: 20, y: 20) }
        .navigationTitle("")
        .navigationBarHidden(true)
        .padding(.horizontal, 24)
        .onAppear { thisTask = retTask }
    }
}

extension TaskView {
    //MARK: - View Variables & Funcs
    var exitBtn: some View {
        Button { withAnimation { presentationMode.wrappedValue.dismiss() }
        } label: {
            Image(systemName: "xmark.circle")
                .mImg(size: 30)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(retTask: Task())
    }
}
