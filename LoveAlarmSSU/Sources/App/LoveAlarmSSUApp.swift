//
//  LoveAlarmSSUApp.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

@main
struct LoveAlarmSSUApp: App {

    init() { LocationService.shared.startLocationUpdate() }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
