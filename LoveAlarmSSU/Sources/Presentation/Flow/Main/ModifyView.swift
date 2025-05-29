//
//  ModifyView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ModifyView: View {
    enum TabIdx {
        case profile
        case interest1
        case interest2
    }
    @Environment(AppStore.self) var appStore
    @State var tabIndex: TabIdx = .profile
//    var firstInterest: Interest { appStore. }

    var body: some View {
        VStack(spacing: 0) {
            
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "프로필 수정"))
    }

    func railTab() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("프로필")
                    .font(LAFont.body, weight: tabIndex == .profile ? .strong : .weak)
                    .foregroundStyle(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                Rectangle().fill(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .profile ? 2 : 1)
            }
            .onTapGesture { tabIndex = .profile }
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Text("취향 1")
                        .font(LAFont.body, weight: tabIndex == .interest1 ? .strong : .weak)
                        .foregroundStyle(tabIndex == .interest1 ? LAColor.Content.base : LAColor.Content.disabled)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
//                    LABadge
                }
                Text("프로필")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                Rectangle().fill(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .profile ? 2 : 1)
            }
            .onTapGesture { tabIndex = .profile }
            VStack(spacing: 0) {
                Text("프로필")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                Rectangle().fill(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .profile ? 2 : 1)
            }
            .onTapGesture { tabIndex = .profile }
        }
        .padding(.horizontal, 8)
    }
}
