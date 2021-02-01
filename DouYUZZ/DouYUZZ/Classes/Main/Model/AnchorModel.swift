//
//  AnchorModel.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/1.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit


class AnchorGroup : NSObject{
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
}

class AnchorModel : NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
//    /// 观看人数
    var online : Int = 0
//    ///标签
    var tagDes : String = ""
    
//    init(vertical_src : String, room_name : String, nickname : String) {
//        super.init()
//
////        room_id = dict["room_id"] as! Int
//        self.vertical_src = vertical_src
//        self.room_name = room_name
//        self.nickname = nickname
////        isVertical = dict["is_vertical"] as! Int
//    }
    init(dict : [String : Any]) {
        super.init()
        room_id = dict["room_id"] as! Int
        vertical_src = dict["vertical_src"] as! String
        room_name = dict["room_name"] as! String
        nickname = dict["nickname"] as! String
        isVertical = dict["is_vertical"] as! Int
        online = dict["hn"] as! Int
        tagDes = (dict["od"] is NSNull) ? dict["cate2_name"] as! String : dict["od"] as! String

//        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
