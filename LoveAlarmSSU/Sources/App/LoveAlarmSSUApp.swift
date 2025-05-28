//
//  LoveAlarmSSUApp.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

@main
struct LoveAlarmSSUApp: App {
    @State private var onboardingStore = OnboardingStore()
    @State private var onboardingCoordinator = OnboardingCoordinator()
    @State private var appCoordinator = AppCoordinator()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("uuidString") private var uuidString: String?

    init() {
        if uuidString == nil { uuidString = UUID().uuidString }
        LocationService.shared.startLocationUpdate()
    }

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                NavigationStack(path: $onboardingCoordinator.path) {
                    MainView()
                }
                .environment(appCoordinator)
            } else {
                NavigationStack(path: $onboardingCoordinator.path) {
                    onboardingCoordinator
                        .build(.basic)
                        .navigationDestination(for: OnboardingRoute.self) {
                            onboardingCoordinator.build($0)
                        }
                }
                .environment(onboardingStore)
                .environment(onboardingCoordinator)
            }
        }
    }
}
