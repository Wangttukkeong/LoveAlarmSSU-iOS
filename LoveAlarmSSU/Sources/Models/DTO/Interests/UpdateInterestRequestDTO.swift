
//
//  UpdateUserRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

struct UpdateInterestRequestDTO: RequestDTO {
    let category: String
    let subCategory: String
    let hashtagList: [String]
}
