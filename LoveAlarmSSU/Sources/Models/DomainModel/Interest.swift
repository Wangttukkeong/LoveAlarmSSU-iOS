//
//  Interest.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/13/25.
//

import Foundation

struct Interest: DomainModel {
    var category: Category
    var subCategory: SubCategory
    var hashtags: [String] = []

    var requestDTO: CreateInterestRequestDTO {
        .init(category: category.rawValue, subCategory: subCategory.transferValue, hashtagList: hashtags)
    }
}

enum Category: String, CaseIterable, Identifiable {
    case music    = "MUSIC"
    case media    = "MEDIA"
    case game     = "GAME"
    case exercise = "EXERCISE"
    case sports   = "SPORTS"
    case reading  = "READING"
    case fashion  = "FASHION"
    case foodie   = "FOODIE"
    case travel   = "TRAVEL"

    var id: Self { self }

    var displayValue: String {
        switch self {
        case .music:    return "🎧 음악"
        case .media:    return "🎬 미디어"
        case .game:     return "🎮 게임"
        case .exercise: return "🏋️ 운동"
        case .sports:   return "⚽️ 스포츠"
        case .reading:  return "📚 독서"
        case .fashion:  return "👔 패션"
        case .foodie:   return "🍔 식도락"
        case .travel:   return "✈️ 여행"
        }
    }

    var displayValueWithoutEmoji: String {
        switch self {
        case .music:    return "음악"
        case .media:    return "미디어"
        case .game:     return "게임"
        case .exercise: return "운동"
        case .sports:   return "스포츠"
        case .reading:  return "독서"
        case .fashion:  return "패션"
        case .foodie:   return "식도락"
        case .travel:   return "여행"
        }
    }

    var subCategories: [SubCategory] {
        switch self {
        case .music: return MusicSubCategory.allCases.map { .init(parentCategory: .music, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .media: return MediaSubCategory.allCases.map { .init(parentCategory: .media, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .game: return GameSubCategory.allCases.map { .init(parentCategory: .game, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .exercise: return ExerciseSubCategory.allCases.map { .init(parentCategory: .exercise, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .sports: return SportsSubCategory.allCases.map { .init(parentCategory: .sports, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .reading: return ReadingSubCategory.allCases.map { .init(parentCategory: .reading, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .fashion: return FashionSubCategory.allCases.map { .init(parentCategory: .fashion, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .foodie: return FoodieSubCategory.allCases.map { .init(parentCategory: .foodie, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        case .travel: return TravelSubCategory.allCases.map { .init(parentCategory: .travel, transferValue: $0.rawValue, displayValue: $0.displayValue) }
        }
    }

    // MARK: – 서브카테고리
    enum MusicSubCategory: String, CaseIterable, Identifiable {
        case band    = "BAND"
        case hiphop  = "HIPHOP"
        case classic = "CLASSIC"
        case kpop    = "KPOP"

        var id: Self { self }
        var parent: Category { .music }
        var displayValue: String {
            switch self {
            case .band:    return "밴드"
            case .hiphop:  return "힙합"
            case .classic: return "클래식"
            case .kpop:    return "케이팝"
            }
        }
    }

    enum MediaSubCategory: String, CaseIterable, Identifiable {
        case movie       = "MOVIE"
        case drama       = "DRAMA"
        case variety     = "VARIETY"
        case documentary = "DOCUMENTARY"

        var id: Self { self }
        var parent: Category { .media }
        var displayValue: String {
            switch self {
            case .movie:       return "영화"
            case .drama:       return "드라마"
            case .variety:     return "예능"
            case .documentary: return "다큐멘터리"
            }
        }
    }

    enum GameSubCategory: String, CaseIterable, Identifiable {
        case mobile  = "MOBILE"
        case console = "CONSOLE"
        case pc      = "PC"

        var id: Self { self }
        var parent: Category { .game }
        var displayValue: String {
            switch self {
            case .mobile:  return "모바일게임"
            case .console: return "콘솔게임"
            case .pc:      return "PC게임"
            }
        }
    }

    enum ExerciseSubCategory: String, CaseIterable, Identifiable {
        case running    = "RUNNING"
        case gym        = "GYM"
        case climbing   = "CLIMBING"
        case boxing     = "BOXING"
        case swimming   = "SWIMMING"
        case board      = "BOARD"
        case gymnastics = "GYMNASTICS"
        case dance      = "DANCE"

        var id: Self { self }
        var parent: Category { .exercise }
        var displayValue: String {
            switch self {
            case .running:    return "러닝"
            case .gym:        return "헬스"
            case .climbing:   return "클라이밍"
            case .boxing:     return "복싱"
            case .swimming:   return "수영"
            case .board:      return "보드"
            case .gymnastics: return "체조"
            case .dance:      return "댄스"
            }
        }
    }

    enum SportsSubCategory: String, CaseIterable, Identifiable {
        case kbo              = "KBO"
        case kLeague          = "K_LEAGUE"
        case overseasFootball = "OVERSEAS_FOOTBALL"
        case eSports          = "E_SPORTS"
        case basketball       = "BASKETBALL"
        case volleyball       = "VOLLEYBALL"
        case motor            = "MOTORSPORTS"

        var id: Self { self }
        var parent: Category { .sports }
        var displayValue: String {
            switch self {
            case .kbo:              return "KBO"
            case .kLeague:          return "K리그"
            case .overseasFootball: return "해외축구"
            case .eSports:          return "e스포츠"
            case .basketball:       return "농구"
            case .volleyball:       return "배구"
            case .motor:            return "모터스포츠"
            }
        }
    }

    enum ReadingSubCategory: String, CaseIterable, Identifiable {
        case novel           = "NOVEL"
        case essay           = "ESSAY"
        case poem            = "POEM"
        case webNovel        = "WEB_NOVEL"
        case selfDevelopment = "SELF_DEVELOPMENT"

        var id: Self { self }
        var parent: Category { .reading }
        var displayValue: String {
            switch self {
            case .novel:           return "소설"
            case .essay:           return "에세이"
            case .poem:            return "시집"
            case .webNovel:        return "웹소설"
            case .selfDevelopment: return "자기계발서"
            }
        }
    }

    enum FashionSubCategory: String, CaseIterable, Identifiable {
        case street         = "STREET"
        case vintage        = "VINTAGE"
        case classicFashion = "CLASSIC_FASHION"
        case collection     = "COLLECTION"

        var id: Self { self }
        var parent: Category { .fashion }
        var displayValue: String {
            switch self {
            case .street:         return "스트릿"
            case .vintage:        return "빈티지"
            case .classicFashion: return "클래식"
            case .collection:     return "수집"
            }
        }
    }

    enum FoodieSubCategory: String, CaseIterable, Identifiable {
        case restaurant = "RESTAURANT"
        case cafe       = "CAFE"
        case cooking    = "COOKING"

        var id: Self { self }
        var parent: Category { .foodie }
        var displayValue: String {
            switch self {
            case .restaurant: return "맛집탐방"
            case .cafe:       return "카페"
            case .cooking:    return "요리"
            }
        }
    }

    enum TravelSubCategory: String, CaseIterable, Identifiable {
        case domestic = "DOMESTIC"
        case overseas = "OVERSEAS"
        case camping  = "CAMPING"

        var id: Self { self }
        var parent: Category { .travel }
        var displayValue: String {
            switch self {
            case .domestic: return "국내여행"
            case .overseas: return "해외여행"
            case .camping:  return "캠핑"
            }
        }
    }
}

struct SubCategory: Hashable, Identifiable {
    var id: String { transferValue }
    let parentCategory: Category
    let transferValue: String
    let displayValue: String
}
