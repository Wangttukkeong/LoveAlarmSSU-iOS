//
//  LoveAlarmSSUApp.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

@main
struct LoveAlarmSSUApp: App {
    @State private var appStore = AppStore()
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
                NavigationStack(path: $appCoordinator.path) {
                    appCoordinator
                        .build(.main)
                        .navigationDestination(for: AppRoute.self) {
                            appCoordinator.build($0)
                        }
                        .sheet(item: $appCoordinator.sheet) {
                            appCoordinator.buildSheet($0)
                        }
                }
                .environment(appCoordinator)
            } else {
                NavigationStack(path: $onboardingCoordinator.path) {
                    onboardingCoordinator
                        .build(.splash)
                        .navigationDestination(for: OnboardingRoute.self) {
                            onboardingCoordinator.build($0)
                        }
                }
                .environment(onboardingCoordinator)
            }
        }
        .environment(appStore)
    }
}
