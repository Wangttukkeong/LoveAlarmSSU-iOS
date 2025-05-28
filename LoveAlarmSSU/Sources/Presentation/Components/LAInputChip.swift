//
//  LAInputChip.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LAInputChip: View {
    @FocusState private var isFocused: Bool

    let config: Config

    enum Config {
        case existing(text: Binding<String>, onDelete: () -> Void)
        case input(text: Binding<String>, placeholder: String, onSubmit: () -> Void)
    }
    
    var body: some View {
        Group {
            switch config {
            case .existing(let text, let onDelete):
                HStack(spacing: 0) {
                    if !text.wrappedValue.isEmpty {
                        Text("#")
                            .font(LAFont.callout, weight: .regular)
                            .foregroundStyle(LAColor.Content.additive)
                            .padding(.trailing, -2)
                    }
                    TextField("", text: text)
                        .font(LAFont.callout, weight: .regular)
                        .foregroundStyle(LAColor.Content.additive)
                        .frame(height: 20)
                        .padding(.horizontal, 2)
                        .fixedSize()
                        .padding(.trailing, 4)
                    Button(action: onDelete) {
                        Image(.close)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(LAColor.Content.assistive)
                            .frame(width: 20, height: 20)
                    }
                }

            case .input(let text, let placeholder, let onSubmit):
                HStack(spacing: 0) {
                    if !text.wrappedValue.isEmpty {
                        Text("#")
                            .font(LAFont.callout, weight: .regular)
                            .foregroundStyle(LAColor.Content.additive)
                            .padding(.trailing, -1.6)
                    }
                    TextField(placeholder, text: text)
                        .font(LAFont.callout, weight: .regular)
                        .foregroundStyle(LAColor.Content.additive)
                        .frame(height: 20)
                        .padding(.horizontal, 2)
                        .fixedSize()
                        .padding(.trailing, 4)
                        .focused($isFocused)
                        .onSubmit(onSubmit)

                    Button(action: { text.wrappedValue.removeAll() }) {
                        Image(.close)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(LAColor.Content.assistive)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(LAColor.BG.Fill.regular)
        .background(LAStyle.Blur.ultraThin)
        .clipShape(.rect(cornerRadius: 8))
    }
}
