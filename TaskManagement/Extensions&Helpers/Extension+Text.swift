//
//  Extension+Text.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/15/23.
//

import Foundation
import SwiftUI

extension Text {
    func mFont(font: Font, nLine: Int) -> some View {
        self.font(font).lineLimit(nLine).backgrounded()
    }
}
