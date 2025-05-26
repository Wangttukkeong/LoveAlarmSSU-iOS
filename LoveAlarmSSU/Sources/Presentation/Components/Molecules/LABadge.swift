//
//  LABadge.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct LABadge: View {
    let text: String
    var body: some View {
        Text("9")
            .font(LAFont.caption, weight: .regular)
            .foregroundStyle(LAColor.Content.additive)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(LAColor.BG.Fill.regular)
            .clipShape(.rect(cornerRadius: 4))
    }
}
