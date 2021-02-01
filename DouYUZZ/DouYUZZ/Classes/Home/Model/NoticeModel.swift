//
//  NoticeModel.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/1.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class NoticeModel: NSObject {

    //id号
    var id : String = ""
    //预定按钮显示文字
    var act_button_text : String = ""
    //标题
    var act_name : String = ""
    //开始时间
    var act_start_time : String = ""
    //预定人数
    var sub_num : Int = 0
    
    init(dict : [String : Any]) {
        super.init()

        id = dict["id"] as! String
//        setValuesForKeys(dict)
        act_button_text = dict["act_button_text"] as! String
        act_name = dict["act_name"] as! String
        act_start_time = dict["act_start_time"] as! String
        sub_num = dict["sub_num"] as! Int
//
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
}
