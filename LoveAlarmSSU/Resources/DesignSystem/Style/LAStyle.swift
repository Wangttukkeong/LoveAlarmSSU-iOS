//
//  LAStyle.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI
import Foundation

enum LAStyle {

    enum Blur {
        static var bar: Material { Material.bar }
        static var thick: Material { Material.thick }
        static var thin: Material { Material.thin }
        static var ultraThin: Material { Material.ultraThin }
        static var ultraThick: Material { Material.ultraThick }
    }
    enum Shadow {
        enum Elevation {
            enum Ambient {
                static var regular: (Color, CGFloat, CGFloat, CGFloat) {
                    (LAColor.Dim.regular, 32, 0, 0)
                }
            }
        }
    }
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
