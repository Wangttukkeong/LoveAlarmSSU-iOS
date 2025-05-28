//
//  Character+.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

extension Character {
    var isEmoji: Bool {
        unicodeScalars.first?.properties.isEmojiPresentation == true
    }
}
