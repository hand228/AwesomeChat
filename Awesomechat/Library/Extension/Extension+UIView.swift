//
//  Extension+UIView.swift
//  Awesomechat
//
//  Created by LongDN on 05/07/2021.
//

import Foundation
import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
//    func addBoder(widh: CGFloat) {
//        let boderLine = CALayer()
//        boderLine.frame = CGRect(x: 0, y: self.frame.size.height - widh, width: self.frame.width, height: widh)
//        self.layer.addSublayer(boderLine)
//
//    }
}

extension UIView {
    @IBDesignable
    public class Gradient: UIView {
        @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
        @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
        @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
        @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
        @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
        @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

        override public class var layerClass: AnyClass { CAGradientLayer.self }

        var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

        func updatePoints() {
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
            }
        }
        func updateLocations() {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
        func updateColors() {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
        override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updatePoints()
            updateLocations()
            updateColors()
        }

    }
}
