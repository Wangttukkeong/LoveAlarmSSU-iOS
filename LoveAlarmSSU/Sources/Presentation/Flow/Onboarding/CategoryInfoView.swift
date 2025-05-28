//
//  CategoryInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct CategoryInfoView: View {
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator
    @Environment(OnboardingStore.self) private var onboardingStore
    private let progress: Double = 60

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
                ForEach(onboardingStore.categories) { category in
                    LAChip(
                        text: category.displayValue,
                        isSelected: onboardingStore.selectedCategories.contains(category),
                        font: .callout,
                        weight: .weak,
                        color: LAColor.Semantic.Brand.strong,
                        backgroundColor: LAColor.Semantic.Brand.regular,
                        selectedFont: .callout,
                        selectedWeight: .strong,
                        selectedColor: LAColor.Content.elevated,
                        selectedBackgroundColor: LAColor.Semantic.Brand.strong
                    )
                    .onTapGesture {
                        if onboardingStore.selectedCategories.contains(category) { onboardingStore.selectedCategories.remove(category) }
                        else {
                            if onboardingStore.selectedCategories.count >= 2 { return }
                            onboardingStore.selectedCategories.insert(category)
                        }
                    }

                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)

            Spacer()
            LAActionButton(config:
                .single(
                    title: "다음으로",
                    action: {
                        onboardingStore.mapCategories()
                        onboardingCoordinator.push(OnboardingRoute.firstSubCategory)
                    },
                    disableCondition: onboardingStore.selectedCategories.count < 2,
                    subLabel: nil
                )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}


#Preview { CategoryInfoView() }
