//
//  LAActionButton.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LAActionButton: View {
    let config: Config

    enum Config {
        case single(
            title: String,
            action: () -> Void,
            disableCondition: Bool,
            subLabel: String?,
        )
        case doubleHorizontal(
            primaryTitle: String,
            primaryAction: () -> Void,
            primaryDisableCondition: Bool,
            secondaryTitle: String,
            secondaryAction: () -> Void,
            secondaryDisableCondition: Bool,
            subLabel: String?
        )
        case doubleVertical(
            primaryTitle: String,
            primaryAction: () -> Void,
            primaryDisableCondition: Bool,
            secondaryTitle: String,
            secondaryAction: () -> Void,
            secondaryDisableCondition: Bool,
            subLabel: String?
        )
    }

    var body: some View {
        VStack(spacing: 10) {
            switch config {
            case .single(let title, let action, let disableContidion, let subLabel):
                Button(action: action) {
                    Text(title)
                        .font(LAFont.body, weight: .regular)
                        .foregroundStyle(LAColor.Content.elevated)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .conditionalBackgroundBlur(condition: disableContidion, material: LAStyle.Blur.thin)
                        .background(LAColor.Semantic.Brand.strong)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .disabled(disableContidion)
                if let subLabel = subLabel {
                    Text(subLabel)
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.assistive)
                }
            case .doubleHorizontal(let primaryTitle, let primaryAction, let primaryDisableCondition, let secondaryTitle, let secondaryAction, let secondaryDisableCondition, let subLabel):
                Button(action: primaryAction) {
                    Text(primaryTitle)
                        .font(LAFont.body, weight: .regular)
                        .foregroundStyle(LAColor.Content.elevated)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .conditionalBackgroundBlur(condition: primaryDisableCondition, material: LAStyle.Blur.thin)
                        .background(LAColor.Semantic.Brand.strong)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .disabled(primaryDisableCondition)
                Button(action: secondaryAction) {
                    Text(secondaryTitle)
                        .font(LAFont.body, weight: .regular)
                        .foregroundStyle(LAColor.Semantic.Brand.strong)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .conditionalBackgroundBlur(condition: secondaryDisableCondition, material: LAStyle.Blur.thin)
                        .background(LAColor.Semantic.Brand.regular)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .disabled(secondaryDisableCondition)
                if let subLabel = subLabel {
                    Text(subLabel)
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.assistive)
                }
            case .doubleVertical(let primaryTitle, let primaryAction, let primaryDisableCondition, let secondaryTitle, let secondaryAction, let secondaryDisableCondition, let subLabel):
                HStack(spacing: 8) {
                    Button(action: primaryAction) {
                        Text(primaryTitle)
                            .font(LAFont.body, weight: .regular)
                            .foregroundStyle(LAColor.Content.elevated)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .conditionalBackgroundBlur(condition: primaryDisableCondition, material: LAStyle.Blur.thin)
                            .background(LAColor.Semantic.Brand.strong)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .disabled(primaryDisableCondition)
                    Button(action: secondaryAction) {
                        Text(secondaryTitle)
                            .font(LAFont.body, weight: .regular)
                            .foregroundStyle(LAColor.Semantic.Brand.strong)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .conditionalBackgroundBlur(condition: secondaryDisableCondition, material: LAStyle.Blur.thin)
                            .background(LAColor.Semantic.Brand.regular)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .disabled(secondaryDisableCondition)
                }
                if let subLabel = subLabel {
                    Text(subLabel)
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.assistive)
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
}
