//
//  AppStore.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import Foundation
import Combine

@Observable
final class AppStore {
    let locationPublisher = LocationService.shared.currentLocationPublisher
    private var cancellables = Set<AnyCancellable>()

    var user = User()

    var selectedCategories: [Category] = []

    init() { bindLocation() }

    convenience init(user: User) {
        self.init()
        self.user = user
    }

    private func bindLocation() {
        locationPublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                self?.user.userLocation = Location(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            }
            .store(in: &cancellables)
    }
}
