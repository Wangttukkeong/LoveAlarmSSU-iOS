//
//  NearByUserResponse.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

struct NearByUserResponse: ResponseDTO {
    let id: String
    let nickname: String
    let emoji: String
    let interests: [InterestResponseDTO]
    let latitude: Double
    let longitude: Double
    let distance: Double
}
