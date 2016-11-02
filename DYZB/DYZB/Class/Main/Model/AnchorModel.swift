//
//  AnchorModel.swift
//  DYZB
//
//  Created by Chang on 10/31/16.
//
//

import UIKit

class AnchorModel: NSObject {
    //room id
    var room_id : Int = 0
    
    //room pic urlstring
    var vertical_src : String = ""
    
    // 0 is PC live 1 is phone live
    var isVertical : Int = 0
    
    //room name 
    var room_name : String = ""
    
    //Nickname
    var nickname : String = ""
    
    //online people 
    var online : Int = 0
    
    
    //anchor cit
    var anchor_city : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
