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
        self.padding(.all).background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
        }
    }
    
//    func makeToolBars() -> ToolbarContent {
//        ToolbarItem(placement: .navigationBarTrailing) {
//            Button {
//                withAnimation {
//                    showAddTask = true
//                }
//            } label: {
//                Image(systemName: "plus.circle")
//            }
//        }
//        ToolbarItem(placement: .automatic) {
//            Menu {
//                Button {
//                    showCompletedTasks = true
//                    showNotCompletedTasks = false
//                } label: {
//                    Label("Completed Tasks",
//                          image: "circle.grid.3x3.fill")
//                }
//                Button {
//                    showNotCompletedTasks = true
//                    showCompletedTasks = false
//                } label: {
//                    Label("Uncompleted Tasks",
//                          image: "circle.grid.3x3.fill")
//                }
//                Button {
//                    showCompletedTasks = false
//                    showNotCompletedTasks = false
//                } label: {
//                    Label("All Tasks",
//                          image: "circle.grid.3x3.fill")
//                }
//            } label: {
//                Image(systemName: "circle.grid.3x3.fill")
//            }
//        }
//    }
}

