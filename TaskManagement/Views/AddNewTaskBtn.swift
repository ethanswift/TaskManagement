//
//  AddNewTaskBtn.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/17/23.
//

import SwiftUI

struct AddNewTaskBtn: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: Cons.sW / 2,
                   height: 50)
            .overlay(alignment: .center) {
                Text("Add New Task")
                    .foregroundColor(.white)
            }
    }
}

struct AddNewTaskBtn_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskBtn()
    }
}
