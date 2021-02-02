//
//  GameModel.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/2.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class GameModel: NSObject {

    // MARK:- 定义属性
     var tag_name : String = ""
     var icon_url : String = ""
     
     // MARK:- 自定义构造函数
     override init() {
         
     }
     
     init(dict : [String : Any]) {
         super.init()
         tag_name = dict["cate2_name"] as! String
        icon_url = dict["square_icon_url"] as! String
        
     }
     
     override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
