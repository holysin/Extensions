//
//  UICollectionViewExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

/// enum for collection view supplementary view kind
///
/// - header: supplementary header
/// - footer: supplementary footer
public enum UICollectionElementKindSection: String {
    case header = "UICollectionElementKindSectionHeader"
    case footer = "UICollectionElementKindSectionFooter"

    /// if raw value not match, reture footer
    ///
    /// - Parameter rawValue:
    public init(rawValue: String) {
        if rawValue == UICollectionElementKindSection.header.rawValue {
            self = .header
        } else {
            self = .footer
        }
    }
}

extension TypeWrapper where T: UICollectionView {

    /// register cell with cell class name
    ///
    /// - Parameter type: Cell Type
    public func register<T: UICollectionViewCell>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forCellWithReuseIdentifier: type.identifier)
    }

    /// dequeue cell at indexpath, example: let cell = collectionView.dequeueReusableCell(for: indexPath) as SomeCell
    ///
    /// - Parameter indexPath: indexpath
    /// - Returns:
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    /// register supplementary view with enum UICollectionElementKindSection
    ///
    /// - Parameters:
    ///   - type: Supplementay view kind
    ///   - kind: UICollectionElementKindSection
    public func register<T: UICollectionReusableView>(_ type: T.Type, forSupplementaryViewOfKind kind: UICollectionElementKindSection) where T: IdentifierType {
        value.register(type, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: type.identifier)
    }

    /// dequeue supplementay view, example: let header = collectionView.ex.dequeueReusableSupplementaryView(ofKind: .Header, for: IndexPath) as SomeView
    ///
    ///
    /// - Parameters:
    ///   - kind: UICollectionElementKindSection
    ///   - indexPath: indexpath
    /// - Returns: Supplementary View
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: UICollectionElementKindSection, for indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
