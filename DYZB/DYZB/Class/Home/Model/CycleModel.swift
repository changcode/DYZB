//
//  CycleModel.swift
//  DYZB
//
//  Created by Chang on 11/1/16.
//
//

import UIKit

class CycleModel: NSObject {
    var title : String = ""
    var pic_url : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict : room)
        }
    }
    var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
