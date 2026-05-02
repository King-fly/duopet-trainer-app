//
//  DesignSystem.swift
//  duopet-trainer-app
//
//  Duolingo-inspired design system
//

import SwiftUI

// MARK: - Color Palette
extension Color {
    // Primary Duo Colors
    static let duoGreen = Color(hex: "58CC02")
    static let duoGreenDeep = Color(hex: "46A302")
    static let duoBlue = Color(hex: "1CB0F6")
    static let duoBlueDeep = Color(hex: "1899D6")
    static let duoYellow = Color(hex: "FFC800")
    static let duoOrange = Color(hex: "FF9600")
    static let duoOrangeDeep = Color(hex: "CC7800")
    static let duoRed = Color(hex: "FF4B4B")
    static let duoRedDeep = Color(hex: "EA2B2B")
    
    // Background & Surface
    static let bgLight = Color(hex: "FFFFFF")
    static let bgDark = Color(hex: "131F24")
    static let cardLight = Color(hex: "FFFFFF")
    static let cardDark = Color(hex: "1E2C33")
    static let borderLight = Color(hex: "E5E5E5")
    static let borderDark = Color(hex: "37464F")
    static let textLight = Color(hex: "4B4B4B")
    static let textDark = Color(hex: "E5E5E5")
    
    // Convenience
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Adaptive Colors
struct DuoColors {
    @Environment(\.colorScheme) static var colorScheme
    
    static func background(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .bgDark : .bgLight
    }
    
    static func card(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .cardDark : .cardLight
    }
    
    static func border(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .borderDark : .borderLight
    }
    
    static func text(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .textDark : .textLight
    }
    
    static func textSecondary(_ scheme: ColorScheme) -> Color {
        text(scheme).opacity(0.6)
    }
}

// MARK: - 3D Bottom Border (replaces shadow to avoid ghosting)
/// Uses a ZStack with an offset background shape to simulate
/// CSS `border-bottom: 4px solid deepColor` without SwiftUI shadow ghosting.
struct Duo3DBackground: ViewModifier {
    let cornerRadius: CGFloat
    let fillColor: Color
    let borderColor: Color
    let bottomColor: Color
    let bottomHeight: CGFloat
    let strokeWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    // Bottom "shadow" layer — offset down
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(bottomColor)
                        .offset(y: bottomHeight)
                    
                    // Main fill layer
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(fillColor)
                    
                    // Stroke border on top
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: strokeWidth)
                }
            )
    }
}

extension View {
    func duo3DBackground(
        cornerRadius: CGFloat = 20,
        fill: Color,
        border: Color,
        bottom: Color,
        bottomHeight: CGFloat = 3,
        strokeWidth: CGFloat = 2
    ) -> some View {
        modifier(Duo3DBackground(
            cornerRadius: cornerRadius,
            fillColor: fill,
            borderColor: border,
            bottomColor: bottom,
            bottomHeight: bottomHeight,
            strokeWidth: strokeWidth
        ))
    }
}

// MARK: - 3D Button Style
struct Duo3DButtonStyle: ButtonStyle {
    let baseColor: Color
    let deepColor: Color
    let textColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .heavy))
            .tracking(1.5)
            .textCase(.uppercase)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                ZStack {
                    // Bottom 3D layer
                    RoundedRectangle(cornerRadius: 16)
                        .fill(deepColor)
                        .offset(y: configuration.isPressed ? 0 : 4)
                    
                    // Main button surface
                    RoundedRectangle(cornerRadius: 16)
                        .fill(baseColor)
                }
            )
            .offset(y: configuration.isPressed ? 3 : 0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == Duo3DButtonStyle {
    static var duoPrimary: Duo3DButtonStyle {
        Duo3DButtonStyle(baseColor: .duoGreen, deepColor: .duoGreenDeep, textColor: .white)
    }
    static var duoBlue: Duo3DButtonStyle {
        Duo3DButtonStyle(baseColor: .duoBlue, deepColor: .duoBlueDeep, textColor: .white)
    }
    static var duoDanger: Duo3DButtonStyle {
        Duo3DButtonStyle(baseColor: .duoRed, deepColor: .duoRedDeep, textColor: .white)
    }
    static var duoWarning: Duo3DButtonStyle {
        Duo3DButtonStyle(baseColor: .duoYellow, deepColor: Color(hex: "E5B400"), textColor: .white)
    }
}

// MARK: - Outline Button Style
struct DuoOutlineButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        let borderCol = DuoColors.border(colorScheme)
        
        configuration.label
            .font(.system(size: 16, weight: .heavy))
            .tracking(1.5)
            .textCase(.uppercase)
            .foregroundColor(DuoColors.text(colorScheme))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                ZStack {
                    // Bottom 3D layer
                    RoundedRectangle(cornerRadius: 16)
                        .fill(borderCol)
                        .offset(y: configuration.isPressed ? 0 : 3)
                    
                    // Main surface
                    RoundedRectangle(cornerRadius: 16)
                        .fill(DuoColors.background(colorScheme))
                    
                    // Border stroke
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderCol, lineWidth: 2)
                }
            )
            .offset(y: configuration.isPressed ? 2 : 0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Ghost Button Style
struct DuoGhostButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    var foregroundColor: Color? = nil
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .heavy))
            .tracking(1)
            .foregroundColor(foregroundColor ?? DuoColors.text(colorScheme))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isPressed ? Color.primary.opacity(0.05) : Color.clear)
            )
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - DuoCard Modifier
struct DuoCardModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var interactive: Bool = false
    
    func body(content: Content) -> some View {
        content
            .padding(16)
            .duo3DBackground(
                cornerRadius: 20,
                fill: DuoColors.card(colorScheme),
                border: DuoColors.border(colorScheme),
                bottom: DuoColors.border(colorScheme),
                bottomHeight: 3,
                strokeWidth: 2
            )
    }
}

extension View {
    func duoCard(interactive: Bool = false) -> some View {
        modifier(DuoCardModifier(interactive: interactive))
    }
}

// MARK: - Progress Bar
struct DuoProgressBar: View {
    let progress: Double
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(DuoColors.border(colorScheme))
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.duoGreen)
                    .frame(width: geo.size.width * min(max(progress, 0), 1))
                    .animation(.spring(response: 0.4), value: progress)
            }
        }
        .frame(height: 16)
    }
}
