//
//  Category.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/13/25.
//

enum Category: String, CaseIterable {
    case music
    case sports

    var subCategories: [String] {
        switch self {
        case .music: MusicSubCategory.allCases.map { $0.rawValue }
        case .sports: SportsSubCategory.allCases.map { $0.rawValue }
        }
    }

    enum MusicSubCategory: String, CaseIterable {
        case band
        case jazz
        case hiphop
    }

    enum SportsSubCategory: String, CaseIterable {
        case soccer
        case basketball
        case baseball
    }
}

struct SubCategoryWithHashtags: Hashable {
    let category: String
    var hashtags: [String]
}
