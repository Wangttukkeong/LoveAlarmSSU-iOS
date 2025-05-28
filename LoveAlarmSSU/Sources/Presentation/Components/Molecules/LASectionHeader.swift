//
//  LASectionHeader.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LASectionHeader: View {
    let text: String
    let font: LAFont
    let weight: LAFont.Weight
    let subTitleConfig: SubTitleConfig?

    struct SubTitleConfig {
        let text: String
        let font: LAFont
        let weight: LAFont.Weight
    }

    init(text: String, font: LAFont, weight: LAFont.Weight, subTitleConfig: SubTitleConfig? = nil) {
        self.text = text
        self.font = font
        self.weight = weight
        self.subTitleConfig = subTitleConfig
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(text)
                .font(font, weight: weight)
                .foregroundStyle(LAColor.Content.base)
                .padding(.horizontal, 4)
                .padding(.top, font == .headline ? 10 : 8)
                .padding(.bottom, 4)
            Spacer()
            if let subTitleConfig = subTitleConfig {
                Text(subTitleConfig.text)
                    .font(subTitleConfig.font, weight: subTitleConfig.weight)
                    .foregroundStyle(LAColor.Content.assistive)
                    .padding(.horizontal, 4)
                    .padding(.top, font == .headline ? 14 : 12)
                    .padding(.bottom, font == .headline ? 8 : 7)
            }
        }
        .padding(.horizontal, 16)

    }
}
