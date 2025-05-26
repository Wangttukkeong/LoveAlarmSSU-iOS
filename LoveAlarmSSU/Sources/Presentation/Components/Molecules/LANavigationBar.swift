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
            secondaryAction: (() -> Void)? = nil
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
            ): RootTextNavigationBar(
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
                secondaryAction
            ): RootPageNavigationBar(
                text: text,
                primaryLabel: primaryLabel,
                primaryAction: primaryAction,
                secondaryLabel: secondaryLabel,
                secondaryAction: secondaryAction
            )
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

        var body: some View {
            ZStack {
                HStack(spacing: 16) {
                    Button {
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
}
