//
//  Gender.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

enum Gender: String, CaseIterable, Identifiable {
    case male = "MALE"
    case female = "FEMALE"
    var id: Self { self }

    var displayValue: String {
        switch self {
        case .male: "남성"
        case .female: "여성"
        }
    }
}
