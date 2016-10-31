//
//  NetworkTools.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping(_ result : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            finishedCallBack(result)
        }
    }
}
