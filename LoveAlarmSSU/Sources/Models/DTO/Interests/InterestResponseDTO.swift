//
//  InterestResponseDTO.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

struct InterestResponseDTO: ResponseDTO {
    let category: String
    let subCategory: String
    let hashtagList: [String]

    var domainModel: Interest {
        let category = Category(rawValue: category) ?? .music
        let subCategory = category.subCategories.first(where: { $0.transferValue == self.subCategory })
                          ?? .init(parentCategory: category, transferValue: "", displayValue: "")

        return .init(
            category: category,
            subCategory: subCategory,
            hashtags: hashtagList
        )
    }
}
