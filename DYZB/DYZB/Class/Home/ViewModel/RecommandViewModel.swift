//
//  RecommandViewModel.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit

class RecommandViewModel {
    public lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    public lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()

    
}

extension RecommandViewModel {
    
    
    // request recommand data
    public func requestDate(finishedCallback : @escaping () -> ()) {
        // parameter in request
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // GCD group
        let dGroup = DispatchGroup()
        
        
        // 1. request 0st parts data
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: kBigDataRoom_URL, parameters: ["time" : Date.getCurrentTime()]) { (response) in
            //check if get result json
            guard let resultDict = response as? [String : NSObject] else { return }
            
            //check if get data attribute in result json
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            
            self.bigDataGroup.tag_name = "Hot"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                
                let anchor = AnchorModel(dict : dict)
                self.bigDataGroup.anchors.append(anchor)
            }

            dGroup.leave()
        }
        
        
        
        // 2. request 1nd parts data
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: kPrettyShow_URL, parameters: parameters) { (response) in
            
            //check if get result json
            guard let resultDict = response as? [String : NSObject] else { return }
            
            //check if get data attribute in result json
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "Preety"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
               
                let anchor = AnchorModel(dict : dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
            
        }
        
        // 3. request 2-12 parts data
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: kGameShow_URL, parameters: parameters) { (response) in
            
            //check if get result json
            guard let resultDict = response as? [String : NSObject] else { return }
            
            //check if get data attribute in result json
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict : dict)
                self.anchorGroups.append(group)
            }
            
            dGroup.leave()
            
        }
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }
        
    }
    
    
    public func requestCycleDate( finishCallback :@escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: kRecommandCycle_URL, parameters:  ["version" : "2.300"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict : dict))
            }
            
            finishCallback()
        }
    }
}
