//
//  LeftAlignedText.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/17/23.
//

import SwiftUI

struct LeftAlignedText: View {
    let pad: CGFloat
    let text: String?
    let font: Font
    let nLine: Int
    var body: some View {
        HStack {
            Text(text!)
                .mFont(font: font, nLine: nLine)
                .padding(.leading, pad)
            Spacer()
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
}

struct LeftAlignedText_Previews: PreviewProvider {
    static var previews: some View {
        LeftAlignedText(pad: 0, text: "", font: .title, nLine: 1)
    }
}
