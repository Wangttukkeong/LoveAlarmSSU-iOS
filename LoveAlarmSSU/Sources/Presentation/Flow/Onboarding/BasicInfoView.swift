//
//  BasicInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import MapKit
import SwiftUI

struct BasicInfoView: View {
    @FocusState private var emojiFieldFocusState: Bool
    @FocusState private var nameFieldFocusState: Bool

    @Environment(OnboardingStore.self) private var onboardingStore: OnboardingStore
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator: OnboardingCoordinator

    private let progress: Double = 30

    var body: some View {
        @Bindable var onboardingStore = onboardingStore

        VStack(spacing: 0) {
            LAProgressBar(progress: progress)
            LAHeader(
                title: "필수 프로필을 입력해주세요",
                contents: "이곳은 누구나 볼 수 있는 프로필이에요.",
                size: .large,
                align: .leading
            )
            LAInputField(
                config: .single(
                    isFocused: $emojiFieldFocusState,
                    title: "나를 표현하는 이모티콘",
                    placeholder: "예시) 🥰",
                    text: $onboardingStore.emoji,
                    subLabel: "키보드에서 이모티콘을 자유롭게 입력해주세요!"
                )
            )
            .onChange(of: onboardingStore.emoji) { _, newValue in
                if let firstEmoji = newValue.filter(\.isEmoji).first {
                    onboardingStore.emoji = String(firstEmoji)
                } else {
                    onboardingStore.emoji = ""
                }
            }
            LAInputField(
                config: .single(
                    isFocused: $nameFieldFocusState,
                    title: "닉네임",
                    placeholder: "예시) 김숭실",
                    text: $onboardingStore.name
                )
            )
            LASectionHeader(
                text: "성별",
                font: .callout,
                weight: .weak
            )
            LAOptionPicker(
                config: .doubleVertical,
                contents: Gender.allCases,
                labelKeyPath: \.displayValue,
                subLabelKeyPath: nil,
                selection: $onboardingStore.gender
            )
            LASectionHeader(
                text: "생년월일",
                font: .callout,
                weight: .weak
            )
            YearPicker(
                selectedYear: $onboardingStore.selectedYear
            )
            Spacer()
            LAActionButton(
                config: .single(
                    title: "다음",
                    action: {
                        onboardingCoordinator.push(OnboardingRoute.optional)
                    },
                    disableCondition: onboardingStore.basicDisableCondition,
                    subLabel: nil
                )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}

struct YearPicker: View {
    @Binding var selectedYear: Int?

    private let years: [Int] = {
        let current = Calendar.current.component(.year, from: Date())
        return Array(1900...current).reversed()
    }()


    var body: some View {
        HStack(spacing: 8) {
            Menu {
                ForEach(years, id: \.self) { year in
                    Button {
                        selectedYear = year
                    } label: {
                        Text("\(String(year))년")
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Group {
                        if let selectedYear = selectedYear {
                            Text("\(String(selectedYear))년")
                        } else {
                            Text("연도")
                        }
                    }
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    Spacer()
                    Image(.arrowDown)
                        .renderingMode(.template)
                        .foregroundStyle(LAColor.Content.assistive)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(LAColor.BG.Fill.regular)
                .background(LAStyle.Blur.ultraThin)
                .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
