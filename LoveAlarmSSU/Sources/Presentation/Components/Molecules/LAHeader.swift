//
//  LAHeader.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct LAHeader: View {
    let subTitle: String?
    let title: String
    let contents: String?

    let size: Size
    let align: Align

    enum Size {
        case large
        case small
    }

    enum Align {
        case leading
        case center
        case trailing

        var alignment: Alignment {
            switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            }
        }

        var horizontalAlignment: HorizontalAlignment {
            switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            }
        }

        var textAlignment: TextAlignment {
            switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            }
        }
    }

    var body: some View {
        VStack(spacing: 2) {
            Group {
                if let subTitle = subTitle {
                    Text(subTitle)
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.assistive)
                }
                Text(title)
                    .font(size == .large ? LAFont.headline : LAFont.body, weight: .strong)
                    .foregroundStyle(LAColor.Content.base)
                if let contents = contents {
                    Text(contents)
                        .font(size == .large ? LAFont.paragraphLarge : LAFont.paragraphSmall, weight: .regular)
                        .foregroundStyle(LAColor.Content.additive)
                }
            }
            .frame(maxWidth: .infinity, alignment: align.alignment)
            .multilineTextAlignment(align.textAlignment)
        }
        .padding(.vertical, size == .large ? 16 : 10)
        .padding(.horizontal, 20)
    }
}
