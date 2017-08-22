//
//  URLExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation

extension URL: NamespaceWrappable {}
extension TypeWrapper where T == URL {

    /// parse query parameters in url string
    ///
    /// - Returns: query parameters
    public func queryParams() -> [String: String] {
        var info : [String: String] = [:]
        if let queryString = value.query{
            for parameter in queryString.components(separatedBy: "&") {
                let parts = parameter.components(separatedBy: "=")
                if parts.count > 1{
                    let key = parts[0].removingPercentEncoding
                    let value = parts[1].removingPercentEncoding
                    if key != nil && value != nil{
                        info[key!] = value
                    }
                }
            }
        }
        return info
    }
}
