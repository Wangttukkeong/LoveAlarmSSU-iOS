//
//  NearbyUser.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct NearbyUser: DomainModel, Equatable, Hashable, Identifiable {
    static func == (lhs: NearbyUser, rhs: NearbyUser) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: String
    var nickname: String
    var emoji: String
    var interests: [Interest]
    var location: Location
    var distance: Double

    var requestDTO: Self { self }
}
