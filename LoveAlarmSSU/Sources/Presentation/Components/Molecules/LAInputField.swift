//
//  LAInputField.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct LAInputField: View {
    let config: Config

    enum Config {
        case single(
            isFocused: FocusState<Bool>.Binding,
            title: String? = nil,
            placeholder: String,
            text: Binding<String>,
            subLabel: String? = nil
        )
        case double(
            title: String? = nil,
            isFirstFocused: FocusState<Bool>.Binding,
            fisrtPlaceholder: String, fisrtText: Binding<String>,
            isSecondFocused: FocusState<Bool>.Binding,
            secondPlaceholder: String, secondText: Binding<String>,
            subLabel: String? = nil
        )
    }

    var body: some View {
        switch config {
        case let .single(isFocused, title, placeholder, text, subLabel):
            SingleInputField(
                isFocused: isFocused,
                title: title,
                placeholder: placeholder,
                text: text,
                subLabel: subLabel
            )
        case .double:
            Text("Double")
        }
    }

    private struct SingleInputField: View {
        let isFocused: FocusState<Bool>.Binding
        let title: String?
        let placeholder: String
        let text: Binding<String>
        let subLabel: String?

        var body: some View {
            VStack(spacing: 0) {
                if let title = title {
                    Text(title)
                        .font(LAFont.callout, weight: .regular)
                        .foregroundStyle(LAColor.Content.additive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                        .padding(.leading, 4)
                }

                HStack(spacing: 8) {
                    ZStack {
                        if text.wrappedValue.isEmpty, !isFocused.wrappedValue {
                            Text(placeholder)
                                .font(LAFont.body, weight: .weak)
                                .foregroundStyle(LAColor.Content.assistive)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TextField("", text: text)
                            .font(LAFont.body, weight: .regular)
                            .foregroundStyle(LAColor.Content.base)
                            .focused(isFocused)
                    }
                    Button {
                        text.wrappedValue = ""
                        isFocused.wrappedValue = false
                    } label: {
                        Image(.close)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(LAColor.BG.Fill.regular)
                .background(LAStyle.Blur.ultraThin)
                .clipShape(.rect(cornerRadius: 16))

                if let subLabel = subLabel {
                    Text(subLabel)
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.additive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.horizontal, 4)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
        }
    }
}
