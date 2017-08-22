//
//  StringExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

extension String: NamespaceWrappable {}
public extension TypeWrapper where T == String {

    /// url encoded value of string
    ///
    /// - Returns: url encoded string
    public func urlEncoded() -> String? {
        var charset = CharacterSet.urlHostAllowed
        charset.remove(charactersIn: ";/?:@&=()$, ")
        return value.addingPercentEncoding(withAllowedCharacters: charset)
    }

    /// trim the white space and new lines
    public var trim: String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: format judgement

    /// whether a string is a mobile phone number
    ///
    /// - Returns: true or false
    public var isMobile: Bool {
        if value.characters.count == 0 {
            return false
        }

        let regax = "1[0-9]{10}"
        let test = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regax])

        return test.evaluate(with: value)
    }

    /// whether a string is email format
    public var isEmailFormat: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: value)
    }

    /// get the attributed string with specific linespacing
    ///
    /// - Parameter lineSpacing: line spacing
    /// - Returns: attributed string
    public func attributedString(withLineSpacing lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attr = [NSAttributedStringKey.paragraphStyle: paragraphStyle]
        return NSAttributedString(string: value, attributes: attr)
    }

    // MARK: text size

    ///  get single line string width with specific font
    ///
    /// - Parameter font:
    /// - Returns: line width
    public func singleLineWidth(withFont font: UIFont) -> CGFloat {
        return value.ex.singleLineTextSize(withFont: font).width
    }

    ///  get single line string size with specific font
    ///
    /// - Parameter font:
    /// - Returns: line width
    public func singleLineTextSize(withFont font: UIFont) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight + 5),
                                 attributes: [NSAttributedStringKey.font: font])
    }

    /// get text size with limited width and specific font
    ///
    /// - Parameters:
    ///   - width: width
    ///   - font: font
    /// - Returns: text size
    public func textSize(withWidth width: CGFloat, font: UIFont) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                 attributes: [NSAttributedStringKey.font: font])
    }

    /// get text size with limited width and text attributes
    ///
    /// - Parameters:
    ///   - width: width
    ///   - textAttributes: text attributes
    /// - Returns: text size
    public func textSize(withWidth width: CGFloat,
                  textAttributes: [NSAttributedStringKey: Any]) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                 attributes: textAttributes)
    }

    /// get text size with limited size and text attributes
    ///
    /// - Parameters:
    ///   - size: limited size
    ///   - attributes: text attributes
    /// - Returns: text size
    public func textSize(withLimitedSize size: CGSize, attributes: [NSAttributedStringKey: Any]) -> CGSize {
        let attributedString = NSAttributedString(string: value, attributes: attributes)
        let boundingRect = size
        let textRect = attributedString.boundingRect(with: boundingRect,
                                                     options: .usesLineFragmentOrigin,
                                                     context: nil)
        return textRect.integral.size
    }
}
