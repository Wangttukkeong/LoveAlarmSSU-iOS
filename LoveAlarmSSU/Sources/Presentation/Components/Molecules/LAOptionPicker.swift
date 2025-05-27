//
//  LAOptionPicker.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LAOptionPicker<T: Identifiable>: View {
    let config: Config
    let contents: [T]
    let labelKeyPath: KeyPath<T, String>
    let subLabelKeyPath: KeyPath<T, String>?

    @Binding var selection: T?

    enum Config {
        case doubleHorizontal
        case doubleVertical
        case triple
        case quadruple
        case sextuple
    }

    var body: some View {
        Group {
            switch config {
            case .doubleHorizontal:
                Text("doubleHorizontal")
            case .doubleVertical:
                DoubleVerticalOptionPicker(
                    contents: contents,
                    labelKeyPath: labelKeyPath,
                    subLabelKeyPath: subLabelKeyPath,
                    selection: $selection
                )
            case .triple:
                Text("triple")
            case .quadruple:
                Text("quadruple")
            case .sextuple:
                Text("sextuple")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    private struct DoubleVerticalOptionPicker: View {
        let contents: [T]
        let labelKeyPath: KeyPath<T, String>
        let subLabelKeyPath: KeyPath<T, String>?

        @Binding var selection: T?

        let columns: [GridItem] = [.init(.flexible(), spacing: 8), .init(.flexible())]

        var body: some View {
            LazyVGrid(columns: columns) {
                ForEach(contents) {
                    OptionItem(
                        content: $0,
                        labelKeyPath: labelKeyPath,
                        subLabelKeyPath: subLabelKeyPath,
                        selection: $selection
                    )
                }
            }
        }
    }


    private struct OptionItem: View {
        let content: T
        let labelKeyPath: KeyPath<T, String>
        let subLabelKeyPath: KeyPath<T, String>?

        @Binding var selection: T?

        var isSelected: Bool { selection?.id == content.id }

        var body: some View {
            VStack(spacing: 0) {
                if let subLabelKeyPath = subLabelKeyPath {
                    Text(content[keyPath: subLabelKeyPath])
                        .font(LAFont.footnote, weight: isSelected ? .regular : .weak)
                        .foregroundStyle(isSelected ? LAColor.Semantic.Brand.strong: LAColor.Content.disabled)
                        .frame(maxWidth: .infinity)
                }
                Text(content[keyPath: labelKeyPath])
                    .font(LAFont.body, weight: isSelected ? .strong : .weak)
                    .foregroundStyle(isSelected ? LAColor.Semantic.Brand.strong : LAColor.Content.disabled)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(isSelected ? LAColor.Semantic.Brand.regular : LAColor.BG.Fill.regular)
            .background(LAStyle.Blur.ultraThin)
            .clipShape(.rect(cornerRadius: 8))
            .overlay {
                if isSelected { RoundedRectangle(cornerRadius: 8).stroke(LAColor.Semantic.Brand.strong, lineWidth: 2) }
                else { EmptyView() }
            }
            .onTapGesture {
                if isSelected { selection = nil }
                else { selection = content }
            }
        }
    }
}


