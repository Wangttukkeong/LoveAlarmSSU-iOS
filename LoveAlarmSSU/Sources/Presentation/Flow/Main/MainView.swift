//
//  MainView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Environment(AppStore.self) private var appStore
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: .init(latitude: 37.497, longitude: 126.957),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    )
    @State private var isCameraInitialized = false
    @State private var currentCoordinate: CLLocationCoordinate2D?

    let locationPublisher = LocationService.shared.currentLocationPublisher

    var body: some View {
        ZStack {
            MapView(
                cameraPosition: $cameraPosition,
                currentCoordinate: $currentCoordinate
            )
            VStack(spacing: 0) {
                TopContainer()
                TopButtonGroup()
                Spacer()
                BottomButtonGroup(
                    setCameraButtonAction: setCameraToCurrentLocation,
                    chatButtonAction: presentChatSheet
                )
            }
        }
        .onAppear(perform: fetchUserInfo)
        .onReceive(locationPublisher) { handleCurrentLocation($0) }
        .applyToolbarVisibility(.hidden, for: .navigationBar)

    }
}

private struct MapView: View {
    @Environment(AppStore.self) private var appStore
    @Environment(AppCoordinator.self) private var appCoordinator
    @Binding var cameraPosition: MapCameraPosition
    @Binding var currentCoordinate: CLLocationCoordinate2D?


    var body: some View {
        Map(
            position: $cameraPosition,
            interactionModes: .all
        ) {
            if let coord = currentCoordinate {
                Annotation(coordinate: coord) {
                    CurrentLocationAnnotation()
                } label: { EmptyView() }
            }

            ForEach(appStore.nearbyUsers, id: \.self) { nearby in

                Annotation(coordinate: nearby.location.coordinate) {
                    //FIXME: - 고쳐
                    Button {
                        appCoordinator.presentSheet(AppSheet.profile(nearby))
                    } label: {
                        LAAnnotation(nearbyUser: nearby, isMatched:
                            (nearby.interests.first!.category == .music || nearby.interests.first!.category == .media)
                        )
                    }

                } label: { EmptyView() }

            }
        }
    }
}

private struct CurrentLocationAnnotation: View {
    @Environment(AppStore.self) private var appStore
    var body: some View {
        ZStack {
            Circle()
                .fill(LAColor.BG.Fill.staticGeneral)
                .frame(width: 48, height: 48)
                .shadow(LAStyle.Shadow.Elevation.Key.strong)
            Text(appStore.user.emoji)
                .font(.system(size: 20))
        }
    }
}

private struct TopContainer: View {
    @Environment(AppStore.self) private var appStore

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
        .background(LAStyle.Blur.ultraThin)
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .shadow(LAStyle.Shadow.Elevation.Ambient.regular)
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
                .font(.system(size: 20))
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

private struct TopButtonGroup: View {
    var body: some View {
        HStack {
            Button {

            } label: {
                Image(.settings)
                    .renderingMode(.template)
                    .foregroundStyle(LAColor.Content.base)
                    .padding(16)
                    .background(LAColor.BG.Fill.interactive)
                    .background(LAStyle.Blur.ultraThin)
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(LAStyle.Shadow.Elevation.Ambient.regular)
            }
            Spacer()
            Button {

            } label: {
                Image(.notifications)
                    .renderingMode(.template)
                    .foregroundStyle(LAColor.Content.base)
                    .padding(16)
                    .background(LAColor.BG.Fill.interactive)
                    .background(LAStyle.Blur.ultraThin)
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(LAStyle.Shadow.Elevation.Ambient.regular)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
}

private struct BottomButtonGroup: View {
    @Environment(AppStore.self) private var appStore
    let setCameraButtonAction: () -> Void
    let chatButtonAction: () -> Void

    var body: some View {
        HStack {
            Button(action: setCameraButtonAction) {
                Image(.locationSearching)
                    .renderingMode(.template)
                    .foregroundStyle(LAColor.Content.base)
                    .padding(16)
                    .background(LAColor.BG.Fill.interactive)
                    .background(LAStyle.Blur.ultraThin)
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(LAStyle.Shadow.Elevation.Ambient.regular)
            }
            Button {

            } label: {
                VStack(spacing: 0) {
                    Text(appStore.matchedNearbyUsers.isEmpty ? "😢 아직 일치하는 이성이 없어요ㅠ" : "근처에 일치하는 이성이 \(appStore.matchedNearbyUsers.count)명 있어요")
                        .font(LAFont.callout, weight: .strong)
                        .foregroundStyle(appStore.matchedNearbyUsers.isEmpty ? LAColor.Semantic.Brand.strong : LAColor.Content.elevated)
                    Text(appStore.matchedNearbyUsers.isEmpty ? "원래 찐사랑은 갑자기 나타나지 않아요..."  : "클릭하여 확인하기")
                        .font(LAFont.footnote, weight: .regular)
                        .foregroundStyle(appStore.matchedNearbyUsers.isEmpty ? LAColor.Semantic.Brand.strong : LAColor.Content.elevated)
                }
                .padding(.vertical, 9)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(LAStyle.Blur.ultraThin)
                .background(appStore.matchedNearbyUsers.isEmpty ? LAColor.Semantic.Brand.regular : LAColor.Semantic.Brand.strong)
                .clipShape(.rect(cornerRadius: 12))
            }
            .disabled(appStore.matchedNearbyUsers.isEmpty)
            Button {

            } label: {
                Image(.chat)
                    .renderingMode(.template)
                    .foregroundStyle(LAColor.Content.base)
                    .padding(16)
                    .background(LAColor.BG.Fill.interactive)
                    .background(LAStyle.Blur.ultraThin)
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(LAStyle.Shadow.Elevation.Ambient.regular)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
}

// MARK: - 비즈니스 로직
extension MainView {
    private func fetchUserInfo() {
        guard UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") else { return }
        Task {
            do {
                let user = try await NetworkService.getUser()
                await MainActor.run { appStore.user = user }
            } catch {

            }
        }
    }

    private func setCameraToCurrentLocation() {
        guard let location = LocationService.shared.currentLocation
        else { return }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )
    }

    private func presentChatSheet() {}


    private func handleCurrentLocation(_ location: CLLocation) {
        currentCoordinate = location.coordinate
        guard !isCameraInitialized else { return }
        isCameraInitialized = true
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )









        // FIXME: - 수상한 친구들 생성 로직 지우기
        let weights = [(0.0012, 0.0013), (0.001, -0.0008), (-0.00125, 0.0006), (-0.0014, -0.0016)]
        let names = ["김숭실", "조휴일", "한시오분", "링링"]
        let emojies = ["😘", "🍉", "⚽️", "🐶"]
        let interests: [Interest] = [
            .init(category: .music, subCategory: SubCategory(parentCategory: .music, transferValue: "BAND", displayValue: "밴드"), hashtags: ["검정치마", "The1975"]),
            .init(category: .media, subCategory: SubCategory(parentCategory: .media, transferValue: "MOVIE", displayValue: "영화"), hashtags: ["에에올", "드마카"])
        ]
        let interests2: [Interest] = [
            .init(category: .exercise, subCategory: SubCategory(parentCategory: .exercise, transferValue: "RUNNING", displayValue: "러닝"), hashtags: ["한강런"]),
            .init(category: .game, subCategory: SubCategory(parentCategory: .game, transferValue: "MOBILE", displayValue: "모바일게임"), hashtags: ["롤토체스"])
        ]

        var temp = [NearbyUser]()
        for idx in 0..<4 {
            let newCoord = CLLocationCoordinate2D(latitude: currentCoordinate!.latitude + weights[idx].0, longitude: currentCoordinate!.longitude + weights[idx].1)
            let newNearby = (
                NearbyUser(
                    id: UUID().uuidString,
                    nickname: names[idx],
                    emoji: emojies[idx],
                    interests: idx % 2 == 0 ? interests : interests2,
                    location: Location(from: newCoord),
                    distance: sqrt(pow(weights[0].0, 2) + pow(weights[0].1, 2))
                )
            )

            temp.append(newNearby)
        }
        appStore.nearbyUsers = temp
    }
}


