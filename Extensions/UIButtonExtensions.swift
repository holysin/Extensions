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
    func setImageTintColor(_ color: UIColor, for state: UIControlState, async: Bool = false) {
        if let image = value.image(for: state) {
            if async {
                DispatchQueue.global().async {
                    let tintedImage = image.ex.tintedImage(withColor: color)
                    DispatchQueue.main.async {
                        self.value.setImage(tintedImage, for: state)
                    }
                }
            } else {
                let tintedImage = image.ex.tintedImage(withColor: color)
                value.setImage(tintedImage, for: state)
            }
        }
    }

    func moveImageToTheRightSide() {
        guard let titleLabel = value.titleLabel, let imageView = value.imageView
            else { return }
        value.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
}

