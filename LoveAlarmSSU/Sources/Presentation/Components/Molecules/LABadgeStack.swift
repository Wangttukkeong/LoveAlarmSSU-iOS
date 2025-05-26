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

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: wrap ? 8 : 6) {
                ForEach(contents) {
                    LABadge(text: $0[keyPath: textKeyPath])
                }
            }
            .padding(.vertical, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
