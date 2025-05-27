//
//  OptionalInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//
import SwiftUI

struct OptionalInfoView: View {
    @FocusState private var heightFocusState: Bool
    @FocusState private var majorFocusState: Bool
    @State private var height: String = ""
    @State private var major: String = ""
    private let progress: Double = 40

    let heightRegex = /^[0-9]{3}cm$/
    let majorRegex = /^.*(?:학과|학부)$/
    var disableCondition: Bool {
        height.wholeMatch(of: heightRegex) == nil || major.wholeMatch(of: majorRegex) == nil
    }

    var body: some View {
        VStack(spacing: 0) {
            LAProgressBar(progress: progress)
            LAHeader(
                title: "선택 정보를 입력해주세요",
                contents: "이 정보는 입력하고 싶지 않으면 건너뛰어도 괜찮아요.",
                size: .large,
                align: .leading
            )
            LAInputField(
                config: .single(
                    isFocused: $heightFocusState,
                    title: "키",
                    placeholder: "예시) 165cm",
                    text: $height
                )
            )
            LAInputField(
                config: .single(
                    isFocused: $majorFocusState,
                    title: "학과 (혹은 학부)",
                    placeholder: "예시) 컴퓨터학부",
                    text: $major
                )
            )
            Spacer()
            LAActionButton(
                config: .doubleHorizontal(
                    primaryTitle: "입력 완료",
                    primaryAction: {},
                    primaryDisableCondition: disableCondition,
                    secondaryTitle: "건너뛰기",
                    secondaryAction: {},
                    secondaryDisableCondition: false,
                    subLabel: nil
                )
            )
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

#Preview { OptionalInfoView() }
