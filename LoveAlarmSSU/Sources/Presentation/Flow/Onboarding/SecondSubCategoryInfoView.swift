//
//  SecondSubCategoryInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct SecondSubCategoryInfoView: View {
    @Environment(AppStore.self) private var appStore

    @State private var interests: [Interest] = []

    private var selectedCategory: Category { appStore.selectedCategories[1] }
    let progress: Double = 90

    var body: some View {
        @Bindable var appStore = appStore

        VStack(spacing: 0) {
            LAProgressBar(progress: progress)
            LAHeader(
                title: "\(appStore.user.nickname)님의 \(selectedCategory.displayValueWithoutEmoji) 취향에 대해 알려주세요",
                contents: "더 자세히 적을수록 나와 맞는 소울메이트가 찾아와요!",
                size: .large,
                align: .leading
            )
            LASectionHeader(text: "자세한 취향 분류", font: .subhead, weight: .strong)
            LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                ForEach(selectedCategory.subCategories) { subCategory in
                    LAChip(
                        text: "#\(subCategory.displayValue)",
                        isSelected: interests.contains { $0.subCategory == subCategory },
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
                            if interests.contains(where: { $0.subCategory == subCategory }) {
                                interests.removeAll { $0.subCategory == subCategory }
                            } else {
                                if interests.count >= 2 { return }
                                interests.append(.init(category: selectedCategory, subCategory: subCategory))
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)

            if !interests.isEmpty {
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

                ForEach(interests.indices, id: \.self) { interestIdx in
                    LASectionHeader(
                        text: interests[interestIdx].subCategory.displayValue,
                        font: .footnote,
                        weight: .weak
                    )
                    LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                        ForEach(interests[interestIdx].hashtags.indices, id: \.self) { hashtagIdx in
                            LAInputChip(
                                config: .existing(
                                    text: $interests[interestIdx].hashtags[hashtagIdx],
                                    onDelete: {
                                        interests[interestIdx].hashtags.remove(at: hashtagIdx)
                                    }
                                )
                            )
                        }
                        if interests[interestIdx].hashtags.count < 2 {
                            LAInputChip(
                                config: .input(
                                    text: $interests[interestIdx].subCategory.inputText,
                                    placeholder: "#해시태그를_입력해주세요",
                                    onSubmit: {
                                        interests[interestIdx].hashtags.append(interests[interestIdx].subCategory.inputText)
                                        interests[interestIdx].subCategory.inputText = ""
                                    }
                                )
                            )
                            .onChange(of: interests[interestIdx].subCategory.inputText) { _, newValue in
                                if newValue.count > 10 { interests[interestIdx].subCategory.inputText = String(newValue.prefix(10)) }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                }
            }
            Spacer()
            LAActionButton(config:
                    .single(
                        title: "다음으로",
                        action: {
                            setSecondSubCategory()
                            signUp()
                        },
                        disableCondition: interests.isEmpty,
                        subLabelAttributedString: attributedString
                    )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }

    private var attributedString: AttributedString {
        var string = AttributedString("“시작하기” 버튼을 통해 서비스를 시작하였을 경우, 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다.")
        if let range = string.range(of: "약관의 내용") {
            string[range].underlineStyle = .single
            string[range].foregroundColor = LAColor.Content.additive
            string[range].font = UIFont(name: "SUIT-Bold", size: LAFont.footnote.size).map { .init($0) }
            string[range].link = URL(string: "https://first-adasaurus-740.notion.site/20273fb4cef080caa60bfb1dbef59cf9?source=copy_link")!
        }
        return string
    }
}

extension SecondSubCategoryInfoView {
    func setSecondSubCategory() {
        appStore.user.interests.append(contentsOf: interests)
    }

    func signUp() {
        Task {
            do {
                let user = try await NetworkService.postUser(appStore.user.requestDTO)
                await MainActor.run {
                    appStore.user = user
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                }
            } catch {

            }
        }
    }
}

#Preview {
    FirstSubCategoryInfoView()
}
