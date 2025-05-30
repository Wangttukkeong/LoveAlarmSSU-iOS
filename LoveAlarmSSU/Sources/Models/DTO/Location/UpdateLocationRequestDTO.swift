//
//  UpdateLocationRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import CoreLocation

struct UpdateLocationRequestDTO: RequestDTO {
    let latitude: Double
    let longitude: Double

    init(location: Location) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }

    init(clLocation: CLLocation) {
        self.latitude = clLocation.coordinate.latitude
        self.longitude = clLocation.coordinate.longitude
    }
}
