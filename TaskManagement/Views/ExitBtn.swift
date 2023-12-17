//
//  ExitBtn.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/17/23.
//

import SwiftUI

struct ExitBtn: View {
    @Binding var showAddTask: Bool
    var body: some View {
        Button { withAnimation { showAddTask = false }
        } label: {
            Image(systemName: "xmark.circle")
                .mImg(size: 25)
                .padding(.leading, 30)
        }
    }
}

struct ExitBtn_Previews: PreviewProvider {
    static var previews: some View {
        ExitBtn(showAddTask: .constant(false))
    }
}
