//
//  UpdateUserRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct UpdateUserRequestDTO: RequestDTO {
    let nickname: String
    let phoneNumber: String? = "010-1111-1111"
    let emoji: String
    let gender: String
    let birthdate: String
    let height: Int?
    let department: String?
}
