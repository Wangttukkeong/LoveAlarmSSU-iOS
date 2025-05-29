//
//  MainView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var cameraPosition = MapCameraPosition.automatic

    var body: some View {
        ZStack {
            MapView(cameraPosition: $cameraPosition)
            VStack(spacing: 0) {
                TopContainer()
                
            }
        }
        .applyToolbarVisibility(.hidden, for: .navigationBar)

    }
}

private struct MapView: View {
    @Binding var cameraPosition: MapCameraPosition

    var body: some View {
        Map(
            position: $cameraPosition,
            interactionModes: .all
        ) {
            ForEach(0..<100, id: \.self) {
                Annotation("", coordinate: .init(latitude: CGFloat($0), longitude: 100)) {
                    Circle().frame(width: 24, height: 24)
                }
            }
        }
    }
}

private struct TopContainer: View {
    @Environment(AppStore.self) private var appStore
    // FIXME: - 온보딩 연동 후 교체
    struct TempBadgeModel: Identifiable {
        let id = UUID()
        let text: String
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(" 상대방에게 보이는 내 프로필")
                .font(LAFont.footnote, weight: .weak)
                .foregroundStyle(LAColor.Content.assistive)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.bottom, 4)

            // 가운데 정보
            MiddleSlot()

            LABadgeStackForInterest(contents: appStore.user.interests)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(LAColor.BG.Fill.interactive)
        .background(Material.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)

        Spacer()
    }
}

private struct MiddleSlot: View {
    @Environment(AppStore.self) private var appStore

    private var informations: String {
        "\(appStore.user.birthdate.koreanAge() ?? 0)세\(department)\(height)"
    }

    private var department: String {
        appStore.user.department.isEmpty ? "" : " | \(appStore.user.department)"
    }

    private var height: String {
        appStore.user.height.isEmpty ? "" : " | \(appStore.user.height)"
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // 이모지
            Text(appStore.user.emoji)
                .font(.system(size: 24))
            // 이름 학과 etc..
            VStack(spacing: 2) {
                Text(appStore.user.nickname)
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(informations)
                    .font(LAFont.footnote, weight: .weak)
                    .foregroundStyle(LAColor.Content.additive)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            // 수정 버튼
            Button {

            } label: {
                HStack(spacing: 4) {
                    Image(.photoImageEdit)
                    Text("수정")
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

private struct ButtonGroup {
    
}


#Preview {
//    LAProgressBar(progress: 80)
    MainView()
        .environment(
            AppStore(
                user: User(
                    nickname: "박현수",
                    emoji: "🥸",
                    gender: .male,
                    birthdate: "2000-11-22",
                    height: "199cm",
                    department: "컴퓨터학부",
                    interests: [.init(
                        category: .exercise,
                        subCategory: SubCategory(
                            parentCategory: .exercise,
                            transferValue: "kk",
                            displayValue: "스쿼트"
                        ),
                        hashtags: ["나잘쳐", "아옹"]
                    ),
                                .init(
                                    category: .exercise,
                                    subCategory: SubCategory(
                                        parentCategory: .exercise,
                                        transferValue: "fdas",
                                        displayValue: "벤치"
                                    ),
                                    hashtags: ["아오", "아옹"]
                                )],
                    userLocation: Location(latitude: 37.45838283979024, longitude: 126.89437945811376)
                )
            )
        )
}


