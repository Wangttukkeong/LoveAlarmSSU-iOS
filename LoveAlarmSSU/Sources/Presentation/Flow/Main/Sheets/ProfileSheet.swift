//
//  ProfileSheet.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ProfileSheet: View {
    @Environment(AppCoordinator.self) private var appCoordinator
    let nearbyUser: NearbyUser

    var body: some View {
        VStack(spacing: 0) {
            MiddleSlot(nearbyUser: nearbyUser)
                .padding(.horizontal, 16)
            LABadgeStackForInterest(contents: nearbyUser.interests)
                .padding(.horizontal, 16)
            LAActionButton(
                config: .single(
                    title: "채팅하기",
                    action: {

                    },
                    disableCondition: false,
                    subLabel: nil
                )
            )
            Spacer()
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.sheet(text: "프로필 보기"))
    }
}

private struct MiddleSlot: View {
    let nearbyUser: NearbyUser

    // FIXME: - 아래3개 다수정
    private var informations: String {
        "\((20...25).randomElement()!)세\(department)\(height)"
    }
    private var department: String {
        " | \(["컴퓨터학부", "글로벌미디어학부", "경영학부", "화학공학과"])"
    }
    private var height: String {
        " | \((152...172).randomElement()!)"
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // 이모지
            Text(nearbyUser.emoji)
                .font(.system(size: 20))
            // 이름 학과 etc..
            VStack(spacing: 2) {
                Text(nearbyUser.nickname)
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(informations)
                    .font(LAFont.footnote, weight: .weak)
                    .foregroundStyle(LAColor.Content.additive)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 10)
    }
}
