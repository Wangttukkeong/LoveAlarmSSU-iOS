//
//  LANavigationBar.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct LANavigationBar: View {
    let config: Config

    enum Config {
        case rootText(
            text: String,
            primaryLabel: ImageResource? = nil,
            primaryAction: (() -> Void)? = nil,
            secondaryLabel: ImageResource? = nil,
            secondaryAction: (() -> Void)? = nil
        )
        case rootPage(
            text: String,
            primaryLabel: ImageResource? = nil,
            primaryAction: (() -> Void)? = nil,
            secondaryLabel: ImageResource? = nil,
            secondaryAction: (() -> Void)? = nil,
            backButtonAction: (() -> Void)? = nil
        )
        case sheet(
            text: String
        )
    }

    var body: some View {
        Group {
            switch config {
            case let .rootText(
                text,
                primaryLabel,
                primaryAction,
                secondaryLabel,
                secondaryAction
            ):
                RootTextNavigationBar(
                    text: text,
                    primaryLabel: primaryLabel,
                    primaryAction: primaryAction,
                    secondaryLabel: secondaryLabel,
                    secondaryAction: secondaryAction
                )

            case let .rootPage(
                text,
                primaryLabel,
                primaryAction,
                secondaryLabel,
                secondaryAction,
                backButtonAction
            ):
                RootPageNavigationBar(
                    text: text,
                    primaryLabel: primaryLabel,
                    primaryAction: primaryAction,
                    secondaryLabel: secondaryLabel,
                    secondaryAction: secondaryAction,
                    backButtonAction: backButtonAction
                )
            case .sheet(let text):
                SheetNavigationBar(text: text)
            }
        }
        .frame(height: 60)
//        .ignoresSafeArea(edges: .top)
    }

    private struct RootTextNavigationBar: View {
        let text: String
        let primaryLabel: ImageResource?
        let primaryAction: (() -> Void)?
        let secondaryLabel: ImageResource?
        let secondaryAction: (() -> Void)?

        var body: some View {
            HStack {
                
            }
            Text("Root Text Navigation Bar")
        }
    }

    private struct RootPageNavigationBar: View {
        @Environment(\.dismiss) var dismiss
        let text: String
        let primaryLabel: ImageResource?
        let primaryAction: (() -> Void)?
        let secondaryLabel: ImageResource?
        let secondaryAction: (() -> Void)?
        let backButtonAction: (() -> Void)?

        var body: some View {
            ZStack {
                HStack(spacing: 16) {
                    Button {
                        backButtonAction?()
                        dismiss()
                    } label: {
                        Image(.arrowBack)
                            .renderingMode(.template)
                            .foregroundStyle(LAColor.Content.assistive)
                    }
                    Spacer()
                    if let primaryLabel = primaryLabel {
                        Button {
                            primaryAction?()
                        } label: {
                            Image(primaryLabel)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    if let secondaryLabel = secondaryLabel {
                        Button {
                            secondaryAction?()
                        } label: {
                            Image(secondaryLabel)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(.horizontal, 16)

                Text(text)
                    .font(LAFont.subhead, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
            }
        }
    }

    private struct SheetNavigationBar: View {
        @Environment(\.dismiss) private var dismiss

        let text: String
        var body: some View {
            HStack {
                Text(text)
                    .font(LAFont.title, weight: .strong)
                    .foregroundStyle(LAColor.Content.base)
                    .padding(.horizontal, 4)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(.close)
                        .renderingMode(.template)
                        .foregroundStyle(LAColor.Content.assistive)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 60)
            .padding(.top, 13)
        }
    }
}
