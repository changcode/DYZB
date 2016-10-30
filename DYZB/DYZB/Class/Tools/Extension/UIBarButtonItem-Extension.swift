//
//  File.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit


extension UIBarButtonItem {
    class func createItem(imageName : String, hilightdImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hilightdImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem.init(customView: btn)
    }
    
    //convience consturctor
    //1. start with convenience
    //2. explicity call design constructor
    convenience init(imageName : String, hilightdImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if hilightdImageName != "" {
            btn.setImage(UIImage(named: hilightdImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
