//
//  NotificationsSheet.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct NotificationsSheet: View {
    @Environment(AppCoordinator.self) private var appCoordinator

    var body: some View {
        VStack(spacing: 0) {
            Image(.slot)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.sheet(text: "프로필 보기"))
    }
}

