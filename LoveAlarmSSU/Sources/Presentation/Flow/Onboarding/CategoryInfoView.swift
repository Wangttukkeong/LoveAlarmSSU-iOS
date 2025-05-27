//
//  CategoryInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct CategoryInfoView: View {
    private let progress: Double = 60
    let categories = Category.allCases

    var body: some View {
        VStack(spacing: 0) {
            LAProgressBar(progress: progress)
            LAHeader(
                title: "내 취향 2개를 선택해주세요",
                contents: "이 정보를 바탕으로 운명의 이성이 매칭돼요!",
                size: .large,
                align: .leading
            )
            LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                ForEach(categories) {
                    LAChip(text: $0.displayValue, textColor: LAColor.Semantic.Brand.strong, backgroundColor: LAColor.Semantic.Brand.regular)

                }
            }

            Spacer()
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}

private struct SectionHeader: View {
    let text: String

    var body: some View {
        Text(text)
            .font(LAFont.callout, weight: .weak)
            .foregroundStyle(LAColor.Content.base)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 4)
            .padding(.top, 8)
            .padding(.horizontal, 16)
    }
}

#Preview { CategoryInfoView() }
