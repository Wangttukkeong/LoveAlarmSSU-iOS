//
//  User.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

struct User: DomainModel {
    var phoneNumber: String? = nil
    var nickname: String = ""
    var emoji: String = ""
    var gender: Gender?
    var birthdate: String = ""
    var height: String = ""
    var department: String = ""
    var interests: [Interest] = []
    var userLocation: Location?

    init() {}

    init(
        phoneNumber: String? = nil,
        nickname: String,
        emoji: String,
        gender: Gender,
        birthdate: String,
        height: String,
        department: String,
        interests: [Interest],
        userLocation: Location
    ) {
        self.phoneNumber = phoneNumber
        self.nickname = nickname
        self.emoji = emoji
        self.gender = gender
        self.birthdate = birthdate
        self.height = height
        self.department = department
        self.interests = interests
        self.userLocation = userLocation
    }

    var requestDTO: CreateUserRequestDTO {
        let id = UserDefaults.standard.string(forKey: "uuidString") ?? ""
        let gender = gender?.rawValue ?? ""
        return .init(
            id: id,
            phoneNumber: "010-1111-1111",
            emoji: emoji,
            nickname: nickname,
            gender: gender,
            birthdate: "\(birthdate)-01-01",
            height: height.parseHeight(),
            department: department,
            interests: interests.map { $0.requestDTO },
            location: userLocation.map { $0.requestDTO }
        )
    }

}
