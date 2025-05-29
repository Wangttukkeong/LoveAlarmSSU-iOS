//
//  OptionalInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//
import SwiftUI

struct OptionalInfoView: View {
    @Environment(AppStore.self) private var appStore
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator

    @FocusState private var heightFocusState: Bool
    @FocusState private var departmentFocusState: Bool

    let heightRegex = /^[0-9]{3}cm$/
    let majorRegex = /^.*(?:학과|학부)$/
    var optionalDisableCondition: Bool {
        appStore.user.height.wholeMatch(of: heightRegex) == nil || appStore.user.department.wholeMatch(of: majorRegex) == nil
    }

    private let progress: Double = 40

    var body: some View {
        @Bindable var appStore = appStore

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
                    text: $appStore.user.height
                )
            )
            LAInputField(
                config: .single(
                    isFocused: $departmentFocusState,
                    title: "학과 (혹은 학부)",
                    placeholder: "예시) 컴퓨터학부",
                    text: $appStore.user.department
                )
            )
            Spacer()
            LAActionButton(
                config: .doubleHorizontal(
                    primaryTitle: optionalDisableCondition ? "다음" : "입력 완료",
                    primaryAction: {
                        onboardingCoordinator.push(OnboardingRoute.category)
                    },
                    primaryDisableCondition: optionalDisableCondition,
                    secondaryTitle: "건너뛰기",
                    secondaryAction: {
                        appStore.user.height.removeAll()
                        appStore.user.department.removeAll()
                        onboardingCoordinator.push(OnboardingRoute.category)
                    },
                    secondaryDisableCondition: false,
                    subLabel: nil
                )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "\(Int(progress))% 작성 완료"))
    }
}
