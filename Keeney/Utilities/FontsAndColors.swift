//
//  FontsAndColors.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var keeneyErrorTextGrey: UIColor {
        return UIColor(red: 108.0 / 255.0, green: 115.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    }
    
    class var keeneyEmptyDataBackgroundGrey: UIColor {
        return UIColor(red: 250.0 / 255.0, green: 252.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    }
    class var keeneyBackgroundWhite: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    }
    class var keeneyGreen: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 189.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
}

extension UIFont {
    class func keeneyRegularFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Regular", size: size)
    }
    
    class func keeneyBoldFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Bold", size: size)
    }
    
    class func keeneyMediumFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Medium", size: size)
    }
    
    class func keeneyLightFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Light", size: size)
    }
}
