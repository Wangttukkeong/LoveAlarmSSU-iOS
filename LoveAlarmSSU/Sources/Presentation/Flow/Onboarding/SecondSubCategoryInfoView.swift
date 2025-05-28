//
//  SecondSubCategoryInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct SecondSubCategoryInfoView: View {
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator
    @Environment(OnboardingStore.self) private var onboardingStore

    let progress: Double = 90
    var body: some View {
        @Bindable var onboardingStore = onboardingStore

        VStack(spacing: 0) {
            LAProgressBar(progress: progress)
            LAHeader(
                title: "\(onboardingStore.name)님의 \(onboardingStore.secondCategory.displayValueWithoutEmoji) 취향에 대해 알려주세요",
                contents: "더 자세히 적을수록 나와 맞는 소울메이트가 찾아와요!",
                size: .large,
                align: .leading
            )
            LASectionHeader(text: "자세한 취향 분류", font: .subhead, weight: .strong)
            LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                ForEach(onboardingStore.secondSubCategories) { subCategory in
                    LAChip(
                        text: "#\(subCategory.displayValue)",
                        isSelected: onboardingStore.secondSubCategoriesWithHashtags.filter({ $0.subCategory == subCategory }).count > 0,
                        font: LAFont.callout,
                        weight: .weak,
                        color: LAColor.Content.disabled,
                        backgroundColor: LAColor.BG.Fill.regular,
                        selectedFont: .callout,
                        selectedWeight: .strong,
                        selectedColor: LAColor.Content.inverted,
                        selectedBackgroundColor: LAColor.BG.Fill.inverted
                    )
                    .onTapGesture {
                        withAnimation {
                            if onboardingStore.secondSubCategoriesWithHashtags.filter({ $0.subCategory == subCategory }).count > 0 {
                                onboardingStore.secondSubCategoriesWithHashtags.remove(at: onboardingStore.secondSubCategoriesWithHashtags.firstIndex { $0.subCategory == subCategory } ?? 0)
                            } else {
                                if onboardingStore.secondSubCategoriesWithHashtags.count >= 2 { return }
                                onboardingStore.secondSubCategoriesWithHashtags.append(.init(subCategory: subCategory, hashtags: []))
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)

            if !onboardingStore.secondSubCategoriesWithHashtags.isEmpty {
                LADivider(size: .small)

                LASectionHeader(
                    text: "취향 해시태그",
                    font: .subhead,
                    weight: .strong,
                    subTitleConfig: .init(
                        text: "10자 이내로 작성해주세요",
                        font: .footnote,
                        weight: .weak
                    )
                )
                ForEach(onboardingStore.secondSubCategoriesWithHashtags.indices, id: \.self) { elemIdx in
                    let hashtagsBinding = $onboardingStore.secondSubCategoriesWithHashtags[elemIdx].hashtags

                    LASectionHeader(
                        text: onboardingStore.secondSubCategoriesWithHashtags[elemIdx].subCategory.displayValue,
                        font: .paragraphLarge,
                        weight: .weak
                    )
                    LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                        ForEach(hashtagsBinding.indices, id: \.self) { hashtagIdx in
                            LAInputChip(
                                config: .existing(
                                    text: hashtagsBinding[hashtagIdx],
                                    onDelete: {
                                        onboardingStore.secondSubCategoriesWithHashtags[elemIdx].hashtags.remove(at: hashtagIdx)
                                    }
                                )
                            )
                        }
                        if hashtagsBinding.count < 2 {
                            LAInputChip(
                                config: .input(
                                    text: $onboardingStore.secondSubCategoryInputText[elemIdx],
                                    placeholder: "#해시태그를_입력해주세요",
                                    onSubmit: {
                                        onboardingStore.secondSubCategoriesWithHashtags[elemIdx].hashtags.append(onboardingStore.secondSubCategoryInputText[elemIdx])
                                        onboardingStore.secondSubCategoryInputText[elemIdx] = ""
                                    }
                                )
                            )
                            .onChange(of: onboardingStore.secondSubCategoryInputText[elemIdx]) { _, newValue in
                               if newValue.count > 10 {
                                   onboardingStore.secondSubCategoryInputText[elemIdx] = String(newValue.prefix(10))
                               }
                           }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                }
            }
            Spacer()
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}

#Preview {
    FirstSubCategoryInfoView()
}
