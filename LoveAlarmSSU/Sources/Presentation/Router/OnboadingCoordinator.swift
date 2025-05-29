//
//  OnboardingCoordinator.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import Foundation
import SwiftUI

@Observable
final class OnboardingCoordinator: Routable {
    private(set) var _sheet: (any Identifiable)?

    private(set) var _fullScreenCover: (any Identifiable)?

    var path = NavigationPath()

    func push(_ route: any Hashable) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty { path.removeLast() }
    }
    
    func presentSheet(_ sheet: any Identifiable) {
        self._sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: any Identifiable) {
        self._fullScreenCover = fullScreenCover
    }
    
    func dismissSheet() {
        self._sheet = nil
    }
    
    func dismissFullScreenCover() {
        self._fullScreenCover = nil
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

enum OnboardingRoute: Hashable {
    case basic
    case optional
    case category
    case firstSubCategory
    case secondSubCategory
}
