//
//  CreateInterestRequestDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

struct CreateInterestRequestDTO: RequestDTO {
    let category: String
    let subCategory: String
    let hashtagList: [String]
}
