//
//  SplashView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(OnboardingCoordinator.self) private var onboardingCoordinator

    var body: some View {
        ZStack {
            LAColor.Semantic.Brand.strong.ignoresSafeArea()
            Image(.splashIcon)
        }
        .task {
            try? await Task.sleep(for: .seconds(1))
            onboardingCoordinator.push(OnboardingRoute.initial)
        }
    }
}

#Preview {
    SplashView()
}
