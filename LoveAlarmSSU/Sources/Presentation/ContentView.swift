//
//  ContentView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!\nHello, world!")
                .font(.display, weight: .regular, language: .eng)
                .foregroundStyle(LAColor.Content.additive)
            Text("안녕!\n안녕!")
                .font(.display, weight: .regular)
                .foregroundStyle(LAColor.Content.base)
        }
        .padding()
        .onAppear {
            LocationService.shared.startLocationUpdate()
        }
    }
}

#Preview {
    ContentView()
}

