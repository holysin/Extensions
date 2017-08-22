//
//  UITableViewExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView: NamespaceWrappable {}
extension TypeWrapper where T: UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forCellReuseIdentifier: type.identifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }

    func register<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
    }
    func dequeueReuseableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T? where T: IdentifierType {
        return value.dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
    }

    func dequeueReuseableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func dequeueReuseableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: IdentifierType {
        return value.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T
    }
}
