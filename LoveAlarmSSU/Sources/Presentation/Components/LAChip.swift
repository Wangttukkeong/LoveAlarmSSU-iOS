//
//  LAChip.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LAChip: View {
    let text: String
    let isSelected: Bool
    let font: LAFont
    let weight: LAFont.Weight
    let color: Color
    let backgroundColor: Color
    let selectedFont: LAFont
    let selectedWeight: LAFont.Weight
    let selectedColor: Color
    let selectedBackgroundColor: Color

    var body: some View {
        Text(text)
            .font(isSelected ? selectedFont : font, weight: isSelected ? selectedWeight : weight)
            .foregroundStyle(isSelected ? selectedColor : color)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(isSelected ? selectedBackgroundColor : backgroundColor)
            .background(LAStyle.Blur.ultraThin)
            .clipShape(.rect(cornerRadius: 8))
    }
}
