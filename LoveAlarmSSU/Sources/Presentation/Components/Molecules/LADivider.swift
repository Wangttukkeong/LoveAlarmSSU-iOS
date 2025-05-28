//
//  LADivider.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LADivider: View {
    let size: Size
    enum Size: CGFloat {
        case small = 1
        case medium = 4
        case large = 8
    }
    var body: some View {
        Rectangle()
            .fill(LAColor.Border.Divider.regular)
            .frame(height: size.rawValue)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
    }
}
