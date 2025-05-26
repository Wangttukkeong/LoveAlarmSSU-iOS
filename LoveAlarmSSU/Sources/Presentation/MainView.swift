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
    let locationPublisher = LocationService.shared.currentLocationPublisher

    var body: some View {
        ZStack {
            MapView(cameraPosition: $cameraPosition)
            VStack(spacing: 0) {
                TopContainer()
            }
        }
        .onReceive(locationPublisher) { handleCurrentLocation($0) }
    }
}

private struct MapView: View {
    @Binding var cameraPosition: MapCameraPosition

    var body: some View {
        Map(
            position: $cameraPosition,
            interactionModes: .all
        ) {
            UserAnnotation()

            ForEach(0..<100, id: \.self) {
                Annotation("", coordinate: .init(latitude: CGFloat($0), longitude: 100)) {
                    Circle().frame(width: 24, height: 24)
                }
            }
        }
    }
}

private struct TopContainer: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(" 상대방에게 보이는 내 프로필")
                .font(LAFont.footnote, weight: .weak)
                .foregroundStyle(LAColor.Content.assistive)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 14)

            // 가운데 정보
            MiddleSlot()

            
        }
        .padding(16)
        .background(LAColor.BG.Fill.interactive)
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)

        Spacer()
    }
}

private struct MiddleSlot: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // 이미지
            Image(systemName: "headphones")
                .resizable()
                .frame(width: 24, height: 24)
            // 이름 학과 etc..
            VStack(spacing: 2) {
                Text("조휴일")
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("경영학부 | 만 19세 | 182cm")
                    .font(LAFont.footnote, weight: .weak)
                    .foregroundStyle(LAColor.Content.additive)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 4)
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
    }
}

extension MainView {
    private func handleCurrentLocation(_ location: CLLocation) {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )
    }
}

#Preview {
    MainView()
}
