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

