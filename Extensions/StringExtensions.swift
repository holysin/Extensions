//
//  StringExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
//import CommonCrypto
import UIKit

extension String: NamespaceWrappable {}
public extension TypeWrapper where T == String {

    public func urlEncoded() -> String? {
        var charset = CharacterSet.urlHostAllowed
        charset.remove(charactersIn: ";/?:@&=()$, ")
        return value.addingPercentEncoding(withAllowedCharacters: charset)
    }

//    public func hmacSHA256(key: String) -> String {
//        let str = value.cString(using: String.Encoding.utf8)!
//        let strLen = value.lengthOfBytes(using: String.Encoding.utf8)
//        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
//
//        let keyStr = key.cString(using: String.Encoding.utf8)!
//        let keyLen = key.lengthOfBytes(using: String.Encoding.utf8)
//
//        var data = Data(capacity: digestLen)
//        data.count = digestLen
//        data.withUnsafeMutableBytes {
//            (bytes: UnsafeMutablePointer<UInt8>) in
//            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyStr, keyLen, str, strLen, bytes)
//        }
//        return data.base64EncodedString()
//    }
//
//    public var md5: String {
//        let str = value.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(value.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//
//        return String(format: hash as String)
//    }

    public var isEmailFormat: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: value)
    }

    public var trim: String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func attributedString(withLineSpacing lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attr = [NSAttributedStringKey.paragraphStyle: paragraphStyle]
        return NSAttributedString(string: value, attributes: attr)
    }

    // MARK: only for chinese

    /**
     判断手机号格式是否合法

     :returns: 判断结果
     */
    func isValidPhoneNumber() -> Bool {
        if value.characters.count == 0 {
            return false
        }

        let regax = "1[0-9]{10}"
        let test = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regax])

        return test.evaluate(with: value)

    }

    // MARK: text size
    /**
     获取单行文本的宽度

     - parameter font: 字体

     - returns: 宽度
     */
    func singleLineWidth(withFont font: UIFont) -> CGFloat {
        return value.ex.singleLineTextSize(withFont: font).width
    }

    /**
     获取单行文本所占的大小

     - parameter font: 字体

     - returns: CGSize 格式的大小
     */
    func singleLineTextSize(withFont font: UIFont) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight + 5),
                                 attributes: [NSAttributedStringKey.font: font])
    }

    func textSize(withWidth width: CGFloat, font: UIFont) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                 attributes: [NSAttributedStringKey.font: font])
    }

    func textSize(withWidth width: CGFloat,
                  textAttributes: [NSAttributedStringKey: Any]) -> CGSize {
        return value.ex.textSize(withLimitedSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                 attributes: textAttributes)
    }

    func textSize(withLimitedSize size: CGSize, attributes: [NSAttributedStringKey: Any]) -> CGSize {
        let attributedString = NSAttributedString(string: value, attributes: attributes)
        let boundingRect = size
        let textRect = attributedString.boundingRect(with: boundingRect,
                                                     options: .usesLineFragmentOrigin,
                                                     context: nil)
        return textRect.integral.size
    }
}
