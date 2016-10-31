//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
