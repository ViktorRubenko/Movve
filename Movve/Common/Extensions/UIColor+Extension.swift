//
//  UIColor+Extension.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count != 6) {
            self.init(red: 0.3, green: 0.3, blue: 0.3, alpha: alpha)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((rgbValue & 0x0000FF)) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {
    static var appBackground: UIColor {
        UIColor(hex: "171721", alpha: 1)
    }
    
    static var appTabBar: UIColor {
        UIColor(hex: "e11a38", alpha: 1)
    }
    
    static var appSecondaryTextColor: UIColor {
        UIColor(hex: "919196", alpha: 1)
    }
    
    static var appTextColor: UIColor {
        UIColor(hex: "ffffff", alpha: 1)
    }
    
    static var ratingFrontColor: UIColor {
        UIColor(hex: "fdc432", alpha: 1)
    }
    
    static var buttonColor: UIColor {
        UIColor(hex: "e11a38", alpha: 1)
    }
    
    static var appCellBackground: UIColor {
        UIColor(hex: "303038", alpha: 1)
    }
}
