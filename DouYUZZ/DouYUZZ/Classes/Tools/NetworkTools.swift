//
//  NetworkTools.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/29.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {

    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ Result : Any) -> ()) {
        
        //获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            //获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            //把结果回调
            finishedCallback(result)
        }
    }
}
