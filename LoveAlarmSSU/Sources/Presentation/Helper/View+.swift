//
//  View+.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/26/25.
//

import SwiftUI

extension View {
    func withBackground(_ color: Color) -> some View {
        ZStack {
            color.ignoresSafeArea()
            self
        }
    }

    func withNavigationBar(_ config: LANavigationBar.Config, action: (() -> Void)? = nil) -> some View {
        VStack(spacing: 0) {
            LANavigationBar(config: config)
            self
        }
        .applyToolbarVisibility(.hidden, for: .navigationBar)
    }

    func shadow(_ params: (Color, CGFloat, CGFloat, CGFloat)) -> some View {
        self.shadow(color: params.0, radius: params.1, x: params.2, y: params.3)
    }

    @ViewBuilder
    func applyToolbarVisibility(_ visibility: Visibility, for bar: ToolbarPlacement) -> some View {
        if #available(iOS 18.0, *) {
            self.toolbarVisibility(visibility, for: bar)
        } else {
            self.toolbar(visibility, for: bar)
        }
    }

    @ViewBuilder
    func conditionalBackgroundBlur(condition: Bool, material: Material) -> some View {
        if condition { self.background(material) }
        else { self }
    }
}
