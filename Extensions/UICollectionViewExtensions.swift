//
//  UICollectionViewExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

enum UICollectionElementKindSection: String {
    case Header = "UICollectionElementKindSectionHeader"
    case Footer = "UICollectionElementKindSectionFooter"
    /**
     默认没有正确匹配到 rawValue 则初始化为 Footer

     - parameter rawValue: rawValue

     - returns: UICollectionElementKindSection
     */
    init(rawValue: String) {
        if rawValue == UICollectionElementKindSection.Header.rawValue {
            self = .Header
        } else {
            self = .Footer
        }
    }
}

extension UICollectionView: NamespaceWrappable {}
extension TypeWrapper where T: UICollectionView {
    // Register

    // Register Cell
    func register<T: UICollectionViewCell>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forCellWithReuseIdentifier: type.identifier)
    }

    // Register ReuseableView
    func register<T: UICollectionReusableView>(_ type: T.Type, forSupplementaryViewOfKind kind: String) where T: IdentifierType {
        value.register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.identifier)
    }
    func register<T: UICollectionReusableView>(_ type: T.Type, forSupplementaryViewOfKind kind: UICollectionElementKindSection) where T: IdentifierType {
        value.register(type, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: type.identifier)
    }

    // DequeueReusable
    // Cell
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    // Reuseable View Header/Footer
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(type: T.Type, kind: UICollectionElementKindSection, forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind:String, forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

}
