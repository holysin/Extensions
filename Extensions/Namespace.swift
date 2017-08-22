//
//  Namespace.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation

public protocol NamespaceWrappable {
    associatedtype T
    var ex: T { get }
    static var ex: T.Type { get }
}

extension NamespaceWrappable {
    public var ex: TypeWrapper<Self> {
        return TypeWrapper(value: self)
    }

    public static var ex: TypeWrapper<Self>.Type {
        return TypeWrapper.self
    }
}

public struct TypeWrapper<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

