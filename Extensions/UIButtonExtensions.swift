//
//  UIButtonExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import UIKit

extension UIButton: NamespaceWrappable {}
extension TypeWrapper where T: UIButton {

    /// change button image tint color for state
    ///
    /// - Parameters:
    ///   - color: tint color
    ///   - state: button state
    public func setImageTintColor(_ color: UIColor, for state: UIControlState) {
        if let image = value.image(for: state) {
            let tintedImage = image.ex.tintedImage(withColor: color)
            value.setImage(tintedImage, for: state)
        }
    }

    /// flip the image horizontally
    public func moveImageToTheRightSide() {
        guard let titleLabel = value.titleLabel, let imageView = value.imageView
            else { return }
        value.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
}

