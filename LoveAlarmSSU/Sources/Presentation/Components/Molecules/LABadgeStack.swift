//
//  LABadgeStack.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct LABadgeStack<T: Identifiable>: View {
    let wrap: Bool
    let contents: [T]
    let textKeyPath: KeyPath<T, String>
    let textColor: Color
    let backgroundColor: Color

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: wrap ? 8 : 6) {
                ForEach(contents) {
                    LABadge(
                        text: $0[keyPath: textKeyPath],
                        textColor: textColor,
                        backgroundColor: backgroundColor
                    )
                }
            }
            .padding(.vertical, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct LABadgeStackForInterest: View {
    let grouped: [SubCategory: [HashtagWithID]]
    let subCategoryTextColor = LAColor.Semantic.Brand.strong
    let subCategoryBackgroundColor = LAColor.Semantic.Brand.regular
    let textColor = LAColor.Content.additive
    let backgroundColor = LAColor.BG.Fill.regular

    struct HashtagWithID: Identifiable {
        let id = UUID()
        let hashtag: String
    }

    init(contents: [Interest]) {
        var dict = [SubCategory: [HashtagWithID]]()
        for interest in contents {
            for hashtag in interest.hashtags {
                dict[interest.subCategory, default: []].append(HashtagWithID(hashtag: hashtag))
            }
        }
        grouped = dict
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 6) {
                ForEach(grouped.keys.sorted(by: {$0.displayValue < $1.displayValue}), id: \.self) { subCategory in
                    LABadge(
                        text: "#\(subCategory.displayValue)",
                        textColor: subCategoryTextColor,
                        backgroundColor: subCategoryBackgroundColor
                    )
                    ForEach(grouped[subCategory, default: []]) { hashtag in
                        LABadge(text: "#\(hashtag.hashtag)", textColor: textColor, backgroundColor: backgroundColor)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
