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
        static var thick: Material { Material.thickMaterial }
        static var thin: Material { Material.thinMaterial }
        static var ultraThin: Material { Material.ultraThinMaterial }
        static var ultraThick: Material { Material.ultraThickMaterial }
    }
    enum Shadow {
        enum Elevation {
            enum Ambient {
                static var regular: (Color, CGFloat, CGFloat, CGFloat) {
                    (LAColor.Dim.regular, 32, 0, 0)
                }
            }
            enum Key {
                static var strong: (Color, CGFloat, CGFloat, CGFloat) {
                    (LAColor.Dim.regular, 40, 0, 8)
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
