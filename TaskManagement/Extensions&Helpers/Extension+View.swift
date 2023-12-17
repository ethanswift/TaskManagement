//
//  Extension+View.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import Foundation
import SwiftUI

extension View {
    func backgrounded() -> some View {
        self.padding(.all, 4).background {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.2))
        }
    }
    func mTxtFld(height: CGFloat) -> some View {
        self.frame(width: Cons.sW / 2, height: height).backgrounded()
    }
    func bgwithColor(color: Color) -> some View {
        self.background {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.2)).shadow(radius: 5)
        }
    }
}

struct ExitBtn: View {
    @Binding var showAddTask: Bool
    var body: some View {
        Button { withAnimation { showAddTask = false }
        } label: {
            Image(systemName: "xmark.circle")
                .mImg(size: 25)
                .padding(.leading, 30)
                .padding(.top, 30)
        }
    }
}

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


