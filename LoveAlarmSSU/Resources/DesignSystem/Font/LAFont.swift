//
//  LAFont.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

enum LAFont {
    case display, title, headline, subhead
    case body, paragraphLarge, paragraphSmall
    case callout, footnote, caption

    enum Weight { case weak, regular, strong }

    enum Language { case kor, eng }

    var size: CGFloat {
        switch self {
        case .display:        return 48
        case .title:          return 24
        case .headline:       return 20
        case .subhead:        return 18
        case .body:           return 16
        case .callout:        return 14
        case .footnote:       return 12
        case .caption:        return 10
        case .paragraphLarge: return 16
        case .paragraphSmall: return 14
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .display:        return 70
        case .title:          return 34
        case .headline:       return 28
        case .subhead:        return 26
        case .body:           return 24
        case .callout:        return 20
        case .footnote:       return 18
        case .caption:        return 14
        case .paragraphLarge: return 28.8
        case .paragraphSmall: return 24
        }
    }
}

struct FontWithLineHeight: ViewModifier {
    let laFont: LAFont
    let weight: LAFont.Weight
    let language: LAFont.Language

    var uiFont: UIFont {
        var uiFontWeight: String {
            switch weight {
            case .weak:    return "Regular"
            case .regular: return "Medium"
            case .strong:  return language == .kor ? "Bold" : "SemiBold"
            }
        }

        var uiFontName: String {
            switch language {
            case .kor: "SUIT-\(uiFontWeight)"
            case .eng: "Inter-\(uiFontWeight)"
            }
        }

        return UIFont(name: uiFontName, size: laFont.size) ?? UIFont.systemFont(ofSize: laFont.size)
    }

    func body(content: Content) -> some View {
        content
            .font(Font(uiFont))
            .lineSpacing(laFont.lineHeight - uiFont.lineHeight)
            .padding(.vertical, (laFont.lineHeight - uiFont.lineHeight) / 2)
    }
}

extension View {
    func font(_ laFont: LAFont, weight: LAFont.Weight, language: LAFont.Language = .kor) -> some View {
        ModifiedContent(
            content: self,
            modifier: FontWithLineHeight(laFont: laFont, weight: weight, language: language) 
        )
    }
}
