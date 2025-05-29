//
//  Location.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct Location: DomainModel {
    var latitude: Double
    var longitude: Double

    var requestDTO: CreateLocationRequestDTO {
        .init(latitude: latitude, longitude: longitude)
    }
}
