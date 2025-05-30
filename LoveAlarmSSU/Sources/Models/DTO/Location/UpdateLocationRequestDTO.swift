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
}
