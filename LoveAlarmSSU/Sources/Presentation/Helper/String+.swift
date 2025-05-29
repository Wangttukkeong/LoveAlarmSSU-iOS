//
//  String+.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

import Foundation

extension String {
    func parseHeight() -> Int? {
        let numericString = self.replacingOccurrences(of: "cm", with: "")
        return Int(numericString.trimmingCharacters(in: .whitespaces))
    }

    func koreanAge() -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")

        guard let birthDate = formatter.date(from: self) else {
            return nil
        }

        let calendar = Calendar.current
        let birthYear = calendar.component(.year, from: birthDate)
        let currentYear = calendar.component(.year, from: Date())

        return currentYear - birthYear + 1
    }
}
