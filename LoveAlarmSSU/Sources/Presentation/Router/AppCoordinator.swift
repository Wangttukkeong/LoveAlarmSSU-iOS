//
//  AppCoordinator.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import Foundation
import SwiftUI

@Observable
final class AppCoordinator: Routable {
    private(set) var sheet: (any Identifiable)?

    private(set) var fullScreenCover: (any Identifiable)?

    var path = NavigationPath()

    func push(_ route: any Hashable) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty { path.removeLast() }
    }

    func presentSheet(_ sheet: any Identifiable) {
        self.sheet = sheet
    }

    func presentFullScreenCover(_ fullScreenCover: any Identifiable) {
        self.fullScreenCover = fullScreenCover
    }

    func dismissSheet() {
        self.sheet = nil
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }

    @ViewBuilder
    func build(_ route: OnboardingRoute) -> some View {
        switch route {
        case .basic: BasicInfoView()
        case .optional: OptionalInfoView()
        case .category: CategoryInfoView()
        case .firstSubCategory: FirstSubCategoryInfoView()
        case .secondSubCategory: SecondSubCategoryInfoView()
        }
    }
}

enum AppRoute: Hashable {
    case basic
    case optional
    case category
    case firstSubCategory
    case secondSubCategory
}
