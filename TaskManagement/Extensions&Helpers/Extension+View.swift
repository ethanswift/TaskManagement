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

//struct MenuView: View {
//    @Binding var showCompletedTasks: Bool
//    @Binding var showNotCompletedTasks: Bool
//    var body: some View {
//        Menu {
//            Button {
//                showCompletedTasks = true
//                showNotCompletedTasks = false
//            } label: { Text("Completed Tasks") }
//            Button {
//                showNotCompletedTasks = true
//                showCompletedTasks = false
//            } label: { Text("Uncompleted Tasks") }
//            Button {
//                showCompletedTasks = false
//                showNotCompletedTasks = false
//            } label: { Text("All Tasks") }
//        } label: { Image(systemName: "line.3.horizontal.decrease").mImg(size: 30) }
//    }
//}

