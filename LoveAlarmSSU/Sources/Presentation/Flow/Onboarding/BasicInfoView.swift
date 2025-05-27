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
    @State private var emoji: String = ""
    @State private var name: String = ""
    @State private var gender: Gender? = nil
    @State private var selectedYear: Int?
    private let progress: Double = 30

    var disableCondition: Bool {
        emoji.isEmpty || name.isEmpty || gender == nil || selectedYear == nil
    }

    var body: some View {
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
                    text: $emoji,
                    subLabel: "키보드에서 이모티콘을 자유롭게 입력해주세요!"
                )
            )
            LAInputField(
                config: .single(
                    isFocused: $nameFieldFocusState,
                    title: "닉네임",
                    placeholder: "예시) 김숭실",
                    text: $name
                )
            )
            SectionHeader(text: "성별")
            LAOptionPicker(
                config: .doubleVertical,
                contents: Gender.allCases,
                labelKeyPath: \.displayValue,
                subLabelKeyPath: nil,
                selection: $gender
            )
            SectionHeader(text: "생년월일")
            DatePickerView(selectedYear: $selectedYear)
            Spacer()
            LAActionButton(config: .single(title: "다음", action: {}, disableCondition: disableCondition, subLabel: nil))
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

struct DatePickerView: View {
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
                    if let selectedYear = selectedYear {
                        Text("\(String(selectedYear))년")
                            .font(LAFont.body, weight: .regular)
                            .foregroundStyle(LAColor.Content.base)
                    }
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

#Preview {
    BasicInfoView()
}
