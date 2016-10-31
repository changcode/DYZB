//
//  RecommandViewModel.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit

class RecommandViewModel {
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}

extension RecommandViewModel {
    
    
    // request recommand data
    public func requestDate() {
        // parameter in request
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // GCD group
//        let dGroup = DispatchGroup()
        
        
        // 1. request 0st parts data
        
//        print("\(kBigDataRoom_URL)?time=" + Date.getCurrentTime())
//        dGroup.enter()
//        NetworkTools.requestData(.get, URLString: kBigDataRoom_URL, parameters: ["time" : Date.getCurrentTime()]) { (result) in
//            guard let resultDict = result as? [String : NSObject] else { return }
//            
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//            
//            print("\(resultDict)")
//        }
        
        // 2. request 1nd parts data
        
        // 3. request 2-12 parts data
        NetworkTools.requestData(.get, URLString: kGameShow_URL, parameters: parameters) { (response) in
            
            //check if get result json
            guard let resultDict = response as? [String : NSObject] else { return }
            
            //check if get data attribute in result json
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict : dict)
                self.anchorGroups.append(group)
            }
            
            
        }
        
    }
}
