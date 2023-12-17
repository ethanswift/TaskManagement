//
//  MenuView.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/17/23.
//

import SwiftUI

struct MenuView: View {
    @Binding var showCompletedTasks: Bool
    @Binding var showNotCompletedTasks: Bool
    var body: some View {
        Menu {
            Button {
                showCompletedTasks = true
                showNotCompletedTasks = false
            } label: { Text("Completed Tasks") }
            Button {
                showNotCompletedTasks = true
                showCompletedTasks = false
            } label: { Text("Uncompleted Tasks") }
            Button {
                showCompletedTasks = false
                showNotCompletedTasks = false
            } label: { Text("All Tasks") }
        } label: { Image(systemName: "line.3.horizontal.decrease").mImg(size: 25) }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showCompletedTasks: .constant(false), showNotCompletedTasks: .constant(false))
    }
}
