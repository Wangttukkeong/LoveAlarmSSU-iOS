//
//  BasicInfoView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

struct BasicInfoView: View {
    @FocusState private var isFocused: Bool
    @State private var name: String = ""
    var body: some View {
        VStack {
            Header()
            LAInputField(
                config: .single(
                    isFocused: $isFocused,
                    title: "닉네임",
                    placeholder: "예시) 김숭실",
                    text: $name
                )
            )
            Spacer()
        }
        .padding(.horizontal, 16)
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "시작하기"))
    }
}

private struct Header: View {
    var body: some View {
        Text("필수 정보를 입력해주세요")
            .font(LAFont.headline, weight: .strong)
            .foregroundStyle(LAColor.Content.base)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 4)
    }
}

#Preview {
    BasicInfoView()
}
