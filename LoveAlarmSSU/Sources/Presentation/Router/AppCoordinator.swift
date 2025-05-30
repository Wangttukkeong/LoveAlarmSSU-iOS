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
    var _sheet: (any Identifiable)? {
        didSet { dump(_sheet) }
    }
    
    var sheet: AppSheet? {
        get { _sheet as? AppSheet }
        set { _sheet = newValue }
    }
    
    var _fullScreenCover: (any Identifiable)?

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
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .main: MainView()
        case .chat(let nearbyUser): ChatView(nearbyUser: nearbyUser)
        case .modify: ModifyView()
        }
    }

    @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
        switch sheet {
        case .profile(let user):
            ProfileSheet(nearbyUser: user)
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        case .notifications:
            NotificationsSheet()
                .presentationDetents([.height(330)])
                .presentationDragIndicator(.visible)
        case .chat(let users):
            ChatSheet(nearbyUsers: users)
                .presentationDetents([.height(270)])
                .presentationDragIndicator(.visible)
        case .report(let user):
            ReportSheet(nearbyUser: user)
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
        }
    }
}

enum AppRoute: Hashable {
    case main
    case chat(NearbyUser)
    case modify
}

enum AppSheet: Hashable, Identifiable {
    case profile(NearbyUser)
    case notifications
    case chat([NearbyUser])
    case report(NearbyUser)

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .notifications:
            return "notifications"
        case .chat:
            return "chat"
        case .report:
            return "report"
        }
    }
}
