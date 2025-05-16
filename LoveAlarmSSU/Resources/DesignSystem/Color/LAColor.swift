//
//  LAColor.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/10/25.
//

import SwiftUI

enum LAColor {

    // MARK: - Background
    enum BG {
        enum Root {
            static var regular: Color {
                .adaptiveColor(
                    light: .sWhite,
                    dark: .brandSolid2
                )
            }
            static let regularElevated = Color.brandSolid2

            static var strong: Color {
                .adaptiveColor(
                    light: .brandSolid5,
                    dark: .brandSolid1
                )
            }
            static let strongElevated = Color.brandSolid1
        }

        enum Fill {
            static var regular: Color {
                .adaptiveColor(
                    light: .brandGrey.opacity(0.08),
                    dark: .brandWhite.opacity(0.02)
                )
            }
            static let regularElevated = Color.brandWhite.opacity(0.02)

            static var strong: Color {
                .adaptiveColor(
                    light: .brandGrey.opacity(0.12),
                    dark: .brandWhite.opacity(0.04)
                )
            }
            static let strongElevated = Color.brandWhite.opacity(0.02)

            static var staticGeneral: Color {
                .adaptiveColor(
                    light: .sWhite,
                    dark: .brandSolid2
                )
            }
            static let strongGeneralElevated = Color.brandSolid2

            static var staticTranslucent: Color {
                .adaptiveColor(
                    light: .sWhite.opacity(0.8),
                    dark: .brandSolid25
                )
            }
            static let staticTranslucentElevated = Color.brandSolid25


            static var interactive: Color {
                .adaptiveColor(
                    light: .sWhite.opacity(0.8),
                    dark: .brandWhite.opacity(0.04)
                )
            }
            static let interactiveElevated = Color.brandWhite.opacity(0.04)


            static var inverted: Color {
                .adaptiveColor(
                    light: .brandSolid4,
                    dark: .brandWhite
                )
            }
            static let invertedElevated = Color.brandWhite
        }

        enum State {
            static var hover: Color {
                .adaptiveColor(
                    light: .brandBlack.opacity(0.08),
                    dark: .brandWhite.opacity(0.08)
                )
            }
            static let hoverElevated = Color.brandWhite.opacity(0.08)

            static var focused: Color {
                .adaptiveColor(
                    light: .brandGrey.opacity(0.12),
                    dark: .brandWhite.opacity(0.12)
                )
            }
            static let focusedElevated = Color.brandWhite.opacity(0.12)

            static var pressed: Color {
                .adaptiveColor(
                    light: .brandBlack.opacity(0.12),
                    dark: .brandWhite.opacity(0.16)
                )
            }
            static let pressedElevated = Color.brandWhite.opacity(0.16)
        }
    }

    // MARK: - Border
    enum Border {
        enum Divider {
            static var regular: Color {
                .adaptiveColor(
                    light: .brandGrey.opacity(0.2),
                    dark: .brandWhite.opacity(0.08)
                )
            }
            static let regularElevated = Color.brandWhite.opacity(0.16)

            static var strong: Color {
                .adaptiveColor(
                    light: .brandBlack,
                    dark: .brandWhite
                )
            }
            static let strongElevated = Color.brandWhite
        }

        enum Outline {
            static var regular: Color {
                .adaptiveColor(
                    light: .brandGrey.opacity(0.16),
                    dark: .brandWhite.opacity(0.04)
                )
            }
            static let regularElevated = Color.brandWhite.opacity(0.12)

            static var strong: Color {
                .adaptiveColor(
                    light: .brandBlack,
                    dark: .brandWhite
                )
            }
            static let strongElevated = Color.brandWhite
        }
    }

    // MARK: - Content
    enum Content {
        static var base: Color {
            .adaptiveColor(
                light: .brandBlack,
                dark: .brandWhite
            )
        }
        static let baseElevated = Color.brandWhite

        static var additive: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.8),
                dark: .brandWhite.opacity(0.8)
            )
        }
        static let additiveElevated = Color.brandWhite.opacity(0.8)

        static var assistive: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.6),
                dark: .brandWhite.opacity(0.6)
            )
        }
        static let assistiveElevated = Color.brandWhite.opacity(0.8)

        static var disabled: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.4),
                dark: .brandWhite.opacity(0.4)
            )
        }
        static let disabledElevated = Color.brandWhite.opacity(0.8)

        static var inverted: Color {
            .adaptiveColor(
                light: .brandWhite,
                dark: .brandBlack
            )
        }
        static let invertedElevated = Color.brandBlack

        static var elevated: Color {
            .adaptiveColor(
                light: .brandWhite,
                dark: .brandWhite
            )
        }
        static let elevatedElevated = Color.brandWhite
    }

    // MARK: - Semantic
    enum Semantic {
        enum Brand {
            static var regular: Color {
                .adaptiveColor(
                    light: .brandCore.opacity(0.08),
                    dark: .brandCore.opacity(0.12)
                )
            }
            static let regularElevated = Color.brandCore.opacity(0.12)

            static var strong: Color {
                .adaptiveColor(
                    light: .brandCore,
                    dark: .brandCore
                )
            }
            static let strongElevated = Color.brandCore
        }

        enum Success {
            static var regular: Color {
                .adaptiveColor(
                    light: .sGreen.opacity(0.08),
                    dark: .sGreen.opacity(0.12)
                )
            }
            static let regularElevated = Color.sGreen.opacity(0.12)

            static var strong: Color {
                .adaptiveColor(
                    light: .sGreen,
                    dark: .sGreen
                )
            }
            static let strongElevated = Color.sGreen
        }

        enum Warning {
            static var regular: Color {
                .adaptiveColor(
                    light: .sYellow.opacity(0.08),
                    dark: .sYellow.opacity(0.12)
                )
            }
            static let regularElevated = Color.sYellow.opacity(0.12)

            static var strong: Color {
                .adaptiveColor(
                    light: .sYellow,
                    dark: .sYellow
                )
            }
            static let strongElevated = Color.sYellow
        }

        enum Danger {
            static var regular: Color {
                .adaptiveColor(
                    light: .sRed.opacity(0.08),
                    dark: .sRed.opacity(0.12)
                )
            }
            static let regularElevated = Color.sRed.opacity(0.12)

            static var strong: Color {
                .adaptiveColor(
                    light: .sRed,
                    dark: .sRed
                )
            }
            static let strongElevated = Color.sRed
        }

        enum Calendar {
            static var exam: Color {
                .adaptiveColor(
                    light: .sGreen,
                    dark: .sGreen
                )
            }
            static let examElevated = Color.sGreen

            static var home: Color {
                .adaptiveColor(
                    light: .sRed,
                    dark: .sRed
                )
            }
            static let homeElevated = Color.sRed

            static var vacation: Color {
                .adaptiveColor(
                    light: .sBlue,
                    dark: .sBlue
                )
            }
            static let vacationElevated = Color.sBlue

            static var event: Color {
                .adaptiveColor(
                    light: .sIndigo,
                    dark: .sIndigo
                )
            }
            static let eventElevated = Color.sIndigo

            static var stay: Color {
                .adaptiveColor(
                    light: .sOrange,
                    dark: .sOrange
                )
            }
            static let stayElevated = Color.sOrange
        }
    }

    // MARK: - Dim
    enum Dim {
        static var weak: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.08),
                dark: .brandBlack.opacity(0.12)
            )
        }
        static let weakElevated = Color.brandBlack.opacity(0.16)

        static var regular: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.12),
                dark: .brandBlack.opacity(0.16)
            )
        }
        static let regularElevated = Color.brandBlack.opacity(0.24)

        static var strong: Color {
            .adaptiveColor(
                light: .brandBlack.opacity(0.20),
                dark: .brandBlack.opacity(0.24)
            )
        }
        static let strongElevated = Color.brandBlack.opacity(0.32)
    }
}

/// Adaptive Color+
extension Color {
    static func adaptiveColor(light: Color, dark: Color) -> Color {
        Color(uiColor: UIColor {
            switch $0.userInterfaceStyle {
            case .light, .unspecified:
                UIColor(light)
            case .dark:
                UIColor(dark)
            @unknown default:
                UIColor(light)
            }
        })
    }
}
