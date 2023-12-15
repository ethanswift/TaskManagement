//
//  Extension+Image.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/15/23.
//

import Foundation
import SwiftUI

extension Image {
    func mImg(size: CGFloat) -> some View {
        self.resizable().frame(width: size, height: size)
    }
}
