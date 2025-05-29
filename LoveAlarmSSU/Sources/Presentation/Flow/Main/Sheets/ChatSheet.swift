//
//  ChatSheet.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ChatSheet: View {
    let nearbyUsers: [NearbyUser]

    var body: some View {
        ScrollView {
            ForEach(nearbyUsers) { nearbyUser in
                ChatCell(nearbyUser: nearbyUser)
            }
        }
        .frame(height: 200)
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.sheet(text: "채팅"))
    }
}

private struct ChatCell: View {
    @Environment(AppCoordinator.self) private var appCoordinator
    @Environment(\.dismiss) private var dismiss
    let nearbyUser: NearbyUser

    var body: some View {
        HStack(spacing: 8) {
            Text(nearbyUser.emoji)
                .font(.system(size: 20))
            VStack(spacing: 0) {
                Text(nearbyUser.nickname)
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(chatText)
                        .font(LAFont.footnote, weight: nearbyUser.nickname != "한시오분" ? .strong : .weak)
                        .foregroundStyle(nearbyUser.nickname != "한시오분" ? LAColor.Semantic.Brand.strong : LAColor.Content.additive)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(" | \((1...5).randomElement()!)시간 전")
                        .font(LAFont.footnote, weight: .weak)
                        .foregroundStyle(LAColor.Content.assistive)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            if nearbyUser.nickname != "한시오분" {
                Circle()
                    .fill(LAColor.Semantic.Brand.strong)
                    .frame(width: 6, height: 6)
            } else {
                Text("안 읽음")
                    .font(LAFont.footnote, weight: .weak)
                    .foregroundStyle(LAColor.Content.assistive)
            }
        }
        .onTapGesture {
            Task {
                dismiss()
                try? await Task.sleep(for: .seconds(0.2))
                await MainActor.run { appCoordinator.push(AppRoute.chat(nearbyUser)) }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }

    private var chatText: String {
        switch nearbyUser.nickname {
        case "김숭실":
            return "긴 세월에 변하지 않을 그런 사랑 하면 되죠"
        case "한시오분":
            return "죄송해요 팀베이비 좋아하시는 여자분은 딱히..."
        case "링링":
            return "혹시 펫사 다니세요????"
        default:
            return "방금 뵌 것 같은데 이거 안되겠는데요.."
        }
    }
}
