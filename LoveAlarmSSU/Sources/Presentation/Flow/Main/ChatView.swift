//
//  ChatView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ChatView: View {
    let nearbyUser: NearbyUser
    @FocusState private var isFocused: Bool
    @State private var incomingMessages: [Message] = []
    @State private var outgoingMessages: [Message] = []
    @State private var additionalMessages: [Message] = [
        Message(text: "이번에 추가콘 막콘 갔다왔어요", isIncoming: true),
        Message(text: "오 저도 거기 갔다왔어요 거기 맨 앞자리", isIncoming: false),
        Message(text: "누나는 검정치마 최애 앨범 뭐에요", isIncoming: false),
        Message(text: "떨스티랑 201 좋아해요 대신 팀베이비 혐오함", isIncoming: true),
        Message(text: "테토녀에요 에겐녀에요", isIncoming: false),
        Message(text: "테토녀요", isIncoming: true),
        Message(text: "제가 집이랑 차 해올테니까 결혼하시죠", isIncoming: false),
        Message(text: "우리 근데 우리가 마지막 세대면 어떡하죠", isIncoming: false),
        Message(text: "긴 세월에 변하지 않을 그런 사랑 하면 되죠", isIncoming: true)
    ]
    @State private var inputText: String = ""

    var body: some View {
        VStack {
            TopView(nearbyUser: nearbyUser)
            ChattingView(
                nearbyUser: nearbyUser,
                incomingMessages: $incomingMessages,
                outgoingMessages: $outgoingMessages,
                additionalMessages: $additionalMessages
            )
            SingleInputField(
                additionalMessages: $additionalMessages,
                isFocused: $isFocused,
                title: nil,
                placeholder: "메시지를 입력하세요",
                text: $inputText,
                subLabel: nil
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "채팅"))
    }
}

private struct ChattingView: View {
    let nearbyUser: NearbyUser

    @Binding var incomingMessages: [Message]
    @Binding var outgoingMessages: [Message]
    @Binding var additionalMessages: [Message]


    var body: some View {
        ScrollView {
            ChatCell(additionalMessages: $additionalMessages)
        }
        .rotationEffect(Angle(degrees: 180))
        .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}

private struct ChatCell: View {
    @Binding var additionalMessages: [Message]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(additionalMessages, id: \.id) {
                Text($0.text)
                    .font(LAFont.paragraphSmall, weight: .regular)
                    .foregroundStyle($0.isIncoming ? LAColor.Content.elevated : LAColor.Content.base)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background($0.isIncoming ? LAColor.Semantic.Brand.strong : LAColor.BG.Fill.strong)
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, alignment: $0.isIncoming ? .leading : .trailing)
                    .padding(.horizontal, 16)
                    .padding(.vertical, $0.isIncoming ? 8 : 0)
            }
        }
        .rotationEffect(Angle(degrees: 180))
        .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}

private struct TopView: View {
    let nearbyUser: NearbyUser

    var body: some View {
        VStack {
            MiddleSlot(nearbyUser: nearbyUser)
                .padding(.horizontal, 16)
            LABadgeStackForInterest(contents: nearbyUser.interests)
                .padding(.horizontal, 16)
        }
    }
}

private struct SingleInputField: View {
    @Binding var additionalMessages: [Message]
    let isFocused: FocusState<Bool>.Binding
    let title: String?
    let placeholder: String
    let text: Binding<String>
    let subLabel: String?

    var body: some View {
        VStack(spacing: 0) {
            if let title = title {
                Text(title)
                    .font(LAFont.callout, weight: .regular)
                    .foregroundStyle(LAColor.Content.additive)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                    .padding(.leading, 4)
            }

            HStack(spacing: 8) {
                Button {} label: {
                    Image(.addIcon)
                        .renderingMode(.template)
                        .foregroundStyle(LAColor.Content.assistive)
                }
                ZStack {
                    if text.wrappedValue.isEmpty, !isFocused.wrappedValue {
                        Text(placeholder)
                            .font(LAFont.body, weight: .weak)
                            .foregroundStyle(LAColor.Content.assistive)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    TextField("", text: text)
                        .font(LAFont.body, weight: .regular)
                        .frame(height: 24)
                        .foregroundStyle(LAColor.Content.base)
                        .focused(isFocused)
                }
                Button {
                    additionalMessages.append(Message(text: text.wrappedValue, isIncoming: false))
                    text.wrappedValue = ""
                    isFocused.wrappedValue = false
                } label: {
                    Image(.send)
                        .renderingMode(.template)
                        .foregroundStyle(LAColor.Content.base)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(LAColor.BG.Fill.regular)
            .background(LAStyle.Blur.ultraThin)
            .clipShape(.rect(cornerRadius: 16))

            if let subLabel = subLabel {
                Text(subLabel)
                    .font(LAFont.footnote, weight: .weak)
                    .foregroundStyle(LAColor.Content.additive)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.horizontal, 4)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}


private struct MiddleSlot: View {
    @Environment(AppCoordinator.self) private var appCoordinator
    let nearbyUser: NearbyUser

    // FIXME: - 아래3개 다수정
    private var informations: String {
        "\((20...25).randomElement()!)세\(department)\(height)"
    }
    private var department: String {
        " | \(["컴퓨터학부", "글로벌미디어학부", "경영학부", "화학공학과"].randomElement()!)"
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
            
            Button {
                appCoordinator.presentSheet(AppSheet.report(nearbyUser))
            } label: {
                HStack(spacing: 4) {
                    Image(.report)
                    Text("신고")
                        .font(LAFont.footnote, weight: .regular)
                        .foregroundStyle(LAColor.Content.base)
                }
                .padding(10)
                .background(LAColor.BG.Fill.regular)
                .clipShape(.rect(cornerRadius: 8))
            }
        }
        .padding(.vertical, 10)
    }
}

//#Preview {
//    ChatView()
//}
struct Message: Identifiable {
    var id: String { text }
    let text: String
    let isIncoming: Bool
}
