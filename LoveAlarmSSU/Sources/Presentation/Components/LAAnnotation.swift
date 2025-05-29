//
//  LAAnnotation.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct LAAnnotation: View {
    let nearbyUser: NearbyUser
    let isMatched: Bool

    var body: some View {
        ZStack {
            Image(.annotation)
                .renderingMode(.template)
                .foregroundStyle(
                    isMatched ? LAColor.Semantic.Brand.strong : LAColor.BG.Fill.interactive
                )
                .foregroundStyle(LAStyle.Blur.ultraThin)
                .shadow(LAStyle.Shadow.Elevation.Key.strong)
            Text(nearbyUser.emoji)
                .font(.system(size: 20))
                .offset(x: 0, y: -10)
        }
    }
}

