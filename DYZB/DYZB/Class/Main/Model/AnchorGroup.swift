//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Chang on 10/31/16.
//
//

import UIKit

class AnchorGroup: NSObject {
    
    //root list in group
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    //group title
    var tag_name : String = ""
    
    //group icon
    var icon_name : String = "home_header_phone"
    
    //room list
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            guard let dataArray = value as? [[String : NSObject]] else { return }
//            
//            for dict in dataArray {
//                anchors.append(AnchorModel(dict: dict))
//            }
//        }
//    }
}
