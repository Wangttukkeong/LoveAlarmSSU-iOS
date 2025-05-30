import SwiftUI

struct InitialView: View {
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image(.initialIcon)
                .padding(.bottom, 16)
            Text(topLine)
                .multilineTextAlignment(.center)
                .font(LAFont.display, weight: .weak)
                .foregroundStyle(LAColor.Content.base)
            Text(middleLine)
                .multilineTextAlignment(.center)
                .font(LAFont.display, weight: .weak)
                .foregroundStyle(LAColor.Content.base)
            Text(bottomLine)
                .multilineTextAlignment(.center)
                .font(LAFont.display, weight: .weak)
                .foregroundStyle(LAColor.Content.base)
            Text("좋아하면 숭리는에서\n당신과 딱 맞는 운명을 찾아보세요!")
                .font(LAFont.paragraphLarge, weight: .regular)
                .foregroundStyle(LAColor.Content.additive)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            Spacer()
            LAActionButton(
                config: .single(
                    title: "시작하기",
                    action: { onboardingCoordinator.push(OnboardingRoute.basic) },
                    disableCondition: false,
                    subLabel: nil)
            )
        }
        .withBackground(LAColor.BG.Root.strong)
        .applyToolbarVisibility(.hidden, for: .navigationBar)
    }

    private var topLine: AttributedString {
        var string = AttributedString("5,197명 중")
        if let range = string.range(of: "5,197명") {
            string[range].foregroundColor = LAColor.Semantic.Brand.strong
            string[range].font = UIFont(name: "SUIT-Bold", size: LAFont.display.size).map { .init($0) }
        }
        if let range = string.range(of: " 중") {
            string[range].foregroundColor = LAColor.Content.base
            string[range].font = UIFont(name: "SUIT-Regular", size: LAFont.display.size).map { .init($0) }
        }
        return string
    }

    private var middleLine: AttributedString {
        var string = AttributedString("당신의 운명은")
        if let range = string.range(of: "당신의 운명") {
            string[range].foregroundColor = LAColor.Content.base
            string[range].font = UIFont(name: "SUIT-Bold", size: LAFont.display.size).map { .init($0) }
        }
        if let range = string.range(of: "은") {
            string[range].foregroundColor = LAColor.Content.base
            string[range].font = UIFont(name: "SUIT-Regular", size: LAFont.display.size).map { .init($0) }
        }
        return string
    }

    private var bottomLine: AttributedString {
        var string = AttributedString("누구일까요?")
        string.foregroundColor = LAColor.Content.base
        string.font = UIFont(name: "SUIT-Regular", size: LAFont.display.size).map { .init($0) }
        return string
    }
}


