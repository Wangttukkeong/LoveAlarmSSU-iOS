//
//  LAProgressBar.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/27/25.
//

import SwiftUI

/// Horizontal Progress Bar입니다.
/// - parameter progress: 진척도(0...100).
struct LAProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LAColor.Border.Outline.regular)
                    .frame(height: 4)

                Rectangle()
                    .fill(LAColor.Semantic.Brand.strong)
                    .frame(width: proxy.size.width * CGFloat(progress / 100), height: 4)
            }
        }
        .frame(height: 4)
    }
}
