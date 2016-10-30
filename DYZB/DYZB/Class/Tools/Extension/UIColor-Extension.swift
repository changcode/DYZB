//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
