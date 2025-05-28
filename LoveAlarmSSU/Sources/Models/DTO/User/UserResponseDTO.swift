//
//  UserResponseDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

struct UserResponseDTO: ResponseDTO {
    let phoneNumber: String?
    let nickname: String
    let emoji: String
    let gender: String
    let birthdate: String
    let interestList: [InterestResponseDTO]
    let userLocation: [LocationResponseDTO]
}
