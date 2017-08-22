//
//  UIScrollViewExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

enum ScrollToPosition {
    case top
    case bottom
}

extension UIScrollView: NamespaceWrappable {}
extension TypeWrapper where T: UIScrollView {
    // 动态更新 tableView 会使 contentSize 的值不对，需要手动更新一下。refer: http://stackoverflow.com/a/17517583/1327876
    func fixContentSize() {
        value.contentSize = value.sizeThatFits(CGSize(width: value.bounds.size.width, height: .greatestFiniteMagnitude))
    }

    func scroll(to positon: ScrollToPosition, animated: Bool = true) {
        switch positon {
        case .top:
            var offset = value.contentOffset
            offset.y = -value.contentInset.top
            value.setContentOffset(offset, animated: animated)
        case .bottom:
            if (value.contentSize.height + value.contentInset.bottom + value.contentInset.top < value.bounds.height) {
                return
            }

            var offset = value.contentOffset
            offset.y = (value.contentSize.height - value.bounds.size.height + value.contentInset.bottom);
            value.setContentOffset(offset, animated: animated)
        }
    }

    func setContentOffsetWithoutTriggerScroll(_ contentOffset: CGPoint) {
        var scrollBounds = value.bounds
        scrollBounds.origin = contentOffset
        value.bounds = scrollBounds
    }
}
