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
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .main: MainView()
        }
    }
}

enum AppRoute: Hashable {
    case main
}
