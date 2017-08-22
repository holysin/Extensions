//
//  UIColorExtensions.swift
//  Extensions
//
//  Created by LiuYue on 22/08/2017.
//  Copyright © 2017 threedot.me. All rights reserved.
//

import UIKit

extension UIColor: NamespaceWrappable {}
extension TypeWrapper where T: UIColor {

    /// init color with hex string, like "0x111111", "#111111"
    ///
    /// - Parameters:
    ///   - hex: hex string
    ///   - alpha: alpha value
    /// - Returns: color
    public static func color(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let defaultColor = UIColor.white

        let alphaValue: CGFloat
        if alpha > 1.0 || alpha < 0.0 {
            alphaValue = 1.0
        } else {
            alphaValue = alpha
        }

        var colorText = hex
            .lowercased()
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        switch colorText {
        case let text where text.hasPrefix("0x"):
            colorText = text.substring(from: text.characters.index(text.startIndex, offsetBy: 2))

        case let text where text.hasPrefix("#"):
            colorText = text.substring(from: text.characters.index(text.startIndex, offsetBy: 1))
        default:
            break
        }

        guard colorText.characters.count == 6 else {
            return defaultColor
        }

        var startIndex = colorText.startIndex
        var endIndex = colorText.characters.index(startIndex, offsetBy: 2)

        let rString = colorText.substring(with: Range(uncheckedBounds: (startIndex, endIndex)))

        startIndex = endIndex
        endIndex = colorText.characters.index(startIndex, offsetBy: 2)

        let gString = colorText.substring(with: Range(uncheckedBounds: (startIndex, endIndex)))

        startIndex = endIndex
        endIndex = colorText.characters.index(startIndex, offsetBy: 2)

        let bString = colorText.substring(with: Range(uncheckedBounds: (startIndex, endIndex)))

        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rString as String).scanHexInt32(&r)
        Scanner(string: gString as String).scanHexInt32(&g)
        Scanner(string: bString as String).scanHexInt32(&b)

        return T(red: CGFloat(r) / 255.0
            , green: CGFloat(g) / 255.0
            , blue: CGFloat(b) / 255.0
            , alpha: alphaValue)
    }

    /// random color
    public static var random: UIColor {
        let r = CGFloat(arc4random()%255) / 255
        let g = CGFloat(arc4random()%255) / 255
        let b = CGFloat(arc4random()%255) / 255

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    /// get the interpolated color from self to some color
    ///
    /// - Parameters:
    ///   - end: end color
    ///   - fraction: fraction
    /// - Returns: interpolated color
    public func interpolate(to end: UIColor, fraction: CGFloat) -> UIColor? {
        guard fraction >= 0.0 && fraction <= 1.0
            , let c1 = components
            , let c2 = end.ex.components
            else {
                return nil
        }

        let r = c1.red + (c2.red - c1.red) * fraction
        let g = c1.green + (c2.green - c1.green) * fraction
        let b = c1.blue + (c2.blue - c1.blue) * fraction
        let a = c1.alpha + (c2.alpha - c1.alpha) * fraction

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    /// parse color components
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if value.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let iRed = red * 255.0
            let iGreen = green * 255.0
            let iBlue = blue * 255.0

            return (red:iRed, green:iGreen, blue:iBlue, alpha:alpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}
