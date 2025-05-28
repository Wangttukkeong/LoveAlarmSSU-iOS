//
//  Routable.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

protocol Routable {
    var sheet: (any Identifiable)? { get }
    var fullScreenCover: (any Identifiable)? { get }

    var path: NavigationPath { get }

    func push(_ route: any Hashable)
    func pop()
    func presentSheet(_ sheet: any Identifiable)
    func presentFullScreenCover(_ fullScreenCover: any Identifiable)
    func dismissSheet()
    func dismissFullScreenCover()
}
