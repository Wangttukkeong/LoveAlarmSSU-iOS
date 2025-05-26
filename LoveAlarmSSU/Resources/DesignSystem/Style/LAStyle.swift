//
//  LAStyle.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI
import Foundation

enum LAStyle {
    private enum Blur {}
    private enum Shadow {}
}

struct ss: View {
    var body: some View {
        Circle()
            .frame(width: 25, height: 25)
    }
}

#Preview {
    ss()
}
