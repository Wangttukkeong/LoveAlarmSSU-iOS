//
//  UpdateUserRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct UpdateUserRequestDTO: RequestDTO {
    let nickname: String
    let phoneNumber: String?
    let emoji: String
    let gender: String
    let birthdate: String
    let height: String?
    let department: String?
}
