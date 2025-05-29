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
    let height: Int?
    let department: String?
    let interestList: [InterestResponseDTO]
    let userLocation: LocationResponseDTO

    var domainModel: User {
        .init(
            phoneNumber: phoneNumber,
            nickname: nickname,
            emoji: emoji,
            gender: .init(rawValue: gender) ?? .male,
            birthdate: birthdate,
            height: heightToString(height),
            department: department ?? "",
            interests: interestList.compactMap { $0.domainModel },
            userLocation: userLocation.domainModel
        )
    }

    private func heightToString(_ height: Int?) -> String {
        guard let height else { return "" }
        return "\(height)cm"
    }
}
