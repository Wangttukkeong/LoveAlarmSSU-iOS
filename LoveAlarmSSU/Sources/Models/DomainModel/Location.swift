//
//  Location.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import CoreLocation

struct Location: DomainModel {
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(from coord: CLLocationCoordinate2D) {
        self.latitude = coord.latitude
        self.longitude = coord.longitude
    }

    var requestDTO: CreateLocationRequestDTO {
        .init(latitude: latitude, longitude: longitude)
    }

    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
