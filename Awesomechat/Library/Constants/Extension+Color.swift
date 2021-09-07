//
//  Extension+Color.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255)
        assert(green >= 0 && green <= 255)
        assert(blue >= 0 && blue <= 255)
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
        
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static var myBlue = UIColor(red: 67.0/255.0, green: 86.0/255.0, blue: 180.0/255.0, alpha: 1)
    static var myGray = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
    static var viewBackground = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1)
    static var headerText = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
    static var counterBackground = UIColor(red: 201.0/255.0, green: 35.0/255.0, blue: 35.0/255.0, alpha: 1)
    static var colorTop = UIColor(red: 67.0 / 255.0, green: 86.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0).cgColor
    static var colorBottom = UIColor(red: 61.0 / 255.0, green: 207.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0).cgColor
//    #E5E5E5
    static var colorBackgroundMessages = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1)
}

class Colors {
    
    var gl:CAGradientLayer!
        init() {
            let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
            self.gl = CAGradientLayer()
            self.gl.colors = [colorTop, colorBottom]
            self.gl.locations = [0.0, 1.0]
    }
    
}
