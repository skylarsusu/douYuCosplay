//
//  CycleModel.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/31.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title : String = ""
    //展示的图片地址
    var pic_url : String = ""
    
    //主播信息对应字典
//    var room : [String : NSObject]? {
//        
//    }
    
    init(dict : [String : Any]) {
        super.init()

        title = dict["title"] as! String
//        setValuesForKeys(dict)
        pic_url = dict["pic_url"] as! String
//        print(title)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
}
