//
//  UIImageExtensions.swift
//  Extensions
//
//  Created by LiuYue on 08/08/2017.
//  Copyright © 2017 devliu.com. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

extension UIImage: NamespaceWrappable {}
extension TypeWrapper where T: UIImage {

    /// crop image in area
    ///
    /// - Parameter frame: frame
    /// - Returns: cropped image
    public func cropImage(inArea frame: CGRect) -> UIImage {
        let imageRef = value.cgImage!.cropping(to: frame)
        let croppedImage = UIImage(cgImage: imageRef!)

        return croppedImage
    }


    /// fix image orientation to up
    ///
    /// - Returns: fixed image
    public func fixImageOrientation() -> UIImage {
        if value.imageOrientation == .up {
            return value
        }

        var transform = CGAffineTransform.identity

        switch value.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: value.size.width, y: value.size.height)
            transform = transform.rotated(by: .pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: value.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: value.size.height)
            transform = transform.rotated(by: -.pi / 2)

        default:
            break
        }

        switch value.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: value.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: value.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break
        }

        let newRect = CGRect(x: 0, y: 0, width: value.size.width, height: value.size.height).integral

        guard let selfCGImage = value.cgImage, let colorSpace = selfCGImage.colorSpace
            , let ctx = CGContext(data: nil, width: Int(newRect.size.width), height: Int(newRect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
            else { return UIImage() }


        ctx.concatenate(transform)
        switch value.imageOrientation{
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(selfCGImage, in: CGRect(x: 0, y: 0, width: newRect.size.height, height: newRect.size.width))
        default:
            ctx.draw(selfCGImage, in: newRect)
        }

        let resultImageRef = ctx.makeImage()
        let resultImage = UIImage(cgImage: resultImageRef!)


        return resultImage
    }

    /// generate image with specific color and size
    ///
    /// - Parameters:
    ///   - color: color
    ///   - size: size
    /// - Returns: image
    public static func image(withColor color: UIColor, size: CGSize) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }

    /// tint image with specific color
    ///
    /// - Parameter color: color
    /// - Returns: tinted image
    public func tintedImage(withColor color: UIColor) -> UIImage {
        return value.ex.tintedImage(withColor: color, size: value.size)
    }

    /// tint image with specific color and size
    ///
    /// - Parameters:
    ///   - color: specific color
    ///   - size: size
    /// - Returns: tinted image
    public func tintedImage(withColor color: UIColor, size: CGSize) -> UIImage {
        var image = value.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image

    }

    /// generate qr code from string
    ///
    /// - Parameters:
    ///   - string: string
    ///   - size: qr code size
    ///   - tintColor: foreground color
    ///   - backgroundColor: background color
    /// - Returns: qrcode image
    public static func qrCode(withSting string: String, size: CGSize, tintColor: UIColor = .black, backgroundColor: UIColor = .white) -> UIImage? {
        guard let data = string.data(using: String.Encoding.isoLatin1) else { return nil }

        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")

        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        colorFilter.setDefaults()
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue((CIColor(color: tintColor)), forKey: "inputColor0")
        colorFilter.setValue((CIColor(color: backgroundColor)), forKey: "inputColor1")

        guard let ciImage = colorFilter.outputImage else { return nil }

        let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage!, in: context.boundingBoxOfClipPath)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage
    }

    /// average color from and image
    ///
    /// - Returns: average color
    public func averageColor() -> UIColor {
        var bitmap = [UInt8](repeating: 0, count: 4)

        if #available(iOS 9.0, *) {
            // Get average color.
            let context = CIContext()
            let inputImage: CIImage = value.ciImage ?? CoreImage.CIImage(cgImage: value.cgImage!)
            let extent = inputImage.extent
            let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
            let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
            let outputImage = filter.outputImage!
            let outputExtent = outputImage.extent
            assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)

            // Render to bitmap.
            context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: kCIFormatRGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        } else {
            // Create 1x1 context that interpolates pixels when drawing to it.
            let context = CGContext(data: &bitmap, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            let inputImage = value.cgImage ?? CIContext().createCGImage(value.ciImage!, from: value.ciImage!.extent)

            // Render to bitmap.
            context.draw(inputImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        }

        // Compute result.
        let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        return result
    }
}
