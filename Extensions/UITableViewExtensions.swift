//
//  UITableViewExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

public protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension TypeWrapper where T: UITableView {

    /// register cell with cell class name
    ///
    /// - Parameter type: cell type
    public func register<T: UITableViewCell>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forCellReuseIdentifier: type.identifier)
    }

    /// dequeue cell at indexpath, example: let cell =  tableView.ex.dequeueReuseableCell(for: indexPath) as SomeCell
    ///
    /// - Parameter indexPath: indexpath
    /// - Returns: cell
    public func dequeueReuseableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: IdentifierType {
        return value.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    /// register header or footer view
    ///
    /// - Parameter type: View Type
    public func register<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: IdentifierType {
        value.register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
    }

    /// dequeue header footer view at indexpath, example: let view = tableView.ex.dequeueReuseableHeaderFooterView() as SomeView
    ///
    /// - Returns: view
    public func dequeueReuseableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: IdentifierType {
        return value.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T
    }
}
