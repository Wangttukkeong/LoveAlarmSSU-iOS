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

    @Environment(AppStore.self) private var appStore
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator

    @State private var selectedYear: Int?

    private var basicDisableCondition: Bool {
        appStore.user.emoji.isEmpty || appStore.user.nickname.isEmpty || appStore.user.gender == nil || appStore.user.birthdate.isEmpty
    }
    private let progress: Double = 30

    var body: some View {
        @Bindable var appStore = appStore

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
                    text: $appStore.user.emoji,
                    subLabel: "키보드에서 이모티콘을 자유롭게 입력해주세요!"
                )
            )
            .onChange(of: appStore.user.emoji) { _, newValue in
                if let firstEmoji = newValue.filter(\.isEmoji).first {
                    appStore.user.emoji = String(firstEmoji)
                } else {
                    appStore.user.emoji = ""
                }
            }
            LAInputField(
                config: .single(
                    isFocused: $nameFieldFocusState,
                    title: "닉네임",
                    placeholder: "예시) 김숭실",
                    text: $appStore.user.nickname
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
                selection: $appStore.user.gender
            )
            LASectionHeader(
                text: "생년월일",
                font: .callout,
                weight: .weak
            )
            YearPicker(
                selectedYear: $selectedYear,
                action: setUserBirthDate
            )
            Spacer()
            LAActionButton(
                config: .single(
                    title: "다음",
                    action: {
                        onboardingCoordinator.push(OnboardingRoute.optional)
                    },
                    disableCondition: basicDisableCondition,
                    subLabel: nil
                )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}

extension BasicInfoView {
    private func setUserBirthDate(_ year: String) {
        appStore.user.birthdate = year
    }
}

private struct YearPicker: View {
    @Binding var selectedYear: Int?
    let action: (String) -> Void

    private let years: [String] = {
        let current = Calendar.current.component(.year, from: Date())
        return Array(1900...current)
                    .compactMap { String($0) }
                    .reversed()
    }()


    var body: some View {
        HStack(spacing: 8) {
            Menu {
                ForEach(years, id: \.self) { year in
                    Button {
                        selectedYear = Int(year) ?? 2222
                        action(year)
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
