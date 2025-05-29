//
//  NearbyUser.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct NearbyUser: DomainModel {
    var id: String
    var nickname: String
    var emoji: String
    var interests: [Interest]
    var location: Location
    var distance: Double

    var requestDTO: Self { self }
}
