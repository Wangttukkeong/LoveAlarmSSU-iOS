//
//  ReportSheet.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ReportSheet: View {
    @Environment(\.dismiss) var dismiss

    enum ReportReason: CaseIterable, Identifiable {
        case unpleasantness
        case spam
        case abuse

        var displayValue: String {
            switch self {
            case .unpleasantness:
                "불쾌함 조성 (음란 ∙ 성적 행위)"
            case .spam:
                "스팸 (불법행위를 위한 광고성 정보)"
            case .abuse:
                "욕설 및 비방"
            }
        }
        var id: Self { self }
    }
    let nearbyUser: NearbyUser
    @State private var selectedReason: ReportReason?

    var body: some View {
        VStack(spacing: 0) {
            ForEach(ReportReason.allCases) {
                listCell($0)
            }
            LAActionButton(
                config: .single(
                    title: "신고하기",
                    action: { dismiss() },
                    disableCondition: selectedReason == nil,
                    subLabel: nil
                )
            )
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.sheet(text: "\(nearbyUser.nickname)님 신고"))
    }

    func listCell(_ reason: ReportReason) -> some View {
        HStack(spacing: 8) {
            radioButton(selectedReason == reason)
            Text(reason.displayValue)
                .font(LAFont.body, weight: .regular)
                .foregroundStyle(LAColor.Content.base)
            Spacer()
        }
        .onTapGesture {
            if selectedReason != reason {
                selectedReason = reason
            } else {
                selectedReason = nil
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }

    func radioButton(_ selected: Bool) -> some View {
        if selected {
            ZStack {
                Circle()
                    .fill(LAColor.Semantic.Brand.strong)
                    .frame(width: 24, height: 24)
                Circle()
                    .fill(LAColor.BG.Fill.staticGeneral)
                    .frame(width: 12, height: 12)
            }
        }
        else {
            ZStack {
                Circle()
                    .fill(LAColor.Border.Outline.regular)
                    .frame(width: 24, height: 24)
                Circle()
                    .fill(LAColor.BG.Fill.staticGeneral)
                    .frame(width: 22, height: 22)
            }

        }
    }
}


