//
//  DateExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation

extension Date: NamespaceWrappable { }
extension TypeWrapper where T == Date {
    public static var secondsPerMinute: Double {
        return 60
    }
    public static var secondsPerHour: Double {
        return Date.ex.secondsPerMinute * 60
    }
    public static var secondsPerDay: Double {
        return Date.ex.secondsPerHour * 24
    }
}
