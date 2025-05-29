//
//  AppStore.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//
import CoreLocation
import Foundation
import Combine

@Observable
final class AppStore {
    let locationPublisher = LocationService.shared.currentLocationPublisher
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()

    var user = User()
    var nearbyUsers: [NearbyUser] = []
    // FIXME: 루키톤 후 수정
    var matchedNearbyUsers: [NearbyUser] {
        let mySubCategories = Set(user.interests.compactMap { $0.subCategory })

        return nearbyUsers.filter { nearbyUser in
            let nearbySubCategories = Set(nearbyUser.interests.compactMap(\.subCategory))
            return !mySubCategories.isDisjoint(with: nearbySubCategories)
        }
    }
//    var matchedNearbyUsers: [NearbyUser] = []

    var selectedCategories: [Category] = []

    init() {
        bindLocation()
        bindTimer()
    }

    convenience init(user: User) {
        self.init()
        self.user = user
    }

    private func bindLocation() {
        locationPublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self = self else { return }
                self.user.userLocation = Location(from: location.coordinate)
            }
            .store(in: &cancellables)
    }

    private func bindTimer() {
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                fetchNearbyUsers()
            }
            .store(in: &cancellables)
    }

    // FIXME: - 고쳐
    private func fetchNearbyUsers() {
        guard UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") else { return }
        Task {
            do {
//                let fetchedNearbyUsers = try await NetworkService.getNearbyAll()
//                await MainActor.run { self.nearbyUsers = fetchedNearbyUsers }
            } catch {

            }
        }
    }
}
