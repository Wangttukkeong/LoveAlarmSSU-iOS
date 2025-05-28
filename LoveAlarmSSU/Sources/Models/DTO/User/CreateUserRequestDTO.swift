//
//  CreateUserRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

struct CreateUserRequestDTO: RequestDTO {
    let id: String
    let phoneNumber: String?
    let emoji: String
    let nickname: String
    let gender: String
    let birthdate: String
    let height: Int?
    let department: String?
    let interest: [CreateInterestRequestDTO]?
    let location: String?
}
