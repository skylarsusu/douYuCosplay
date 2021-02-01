//
//  RecommendViewModel.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/31.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit


class RecommendViewModel {
    //懒加载
   lazy var cycleModels : [CycleModel] = [CycleModel]()
   lazy var dataGroup : AnchorGroup = AnchorGroup()
    lazy var notices : [NoticeModel] = [NoticeModel]()
}
extension RecommendViewModel {
    
    func requestNoticeData(_ finishCallBack : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: noticeList) { (result) in
            //1.将result转成字典类型
              guard let resultDict = result as? [String : NSObject] else {return}
              
              //2.根据data的key获取数据
              guard let dataDict = resultDict["data"] as? [String : NSObject] else {return}
              guard let subscribeDetail = dataDict["subscribeDetail"] as? [String : NSObject] else {return}
            
            guard let dataArray = subscribeDetail["list"] as? [[String : NSObject]] else {return}
                       
              for dict in dataArray {
                
                let noticeModel = NoticeModel(dict: dict)
                self.notices.append(noticeModel)
            }
              finishCallBack()
        }
    }
    
    func requestMainData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: recList) { (result) in
           //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in dataArray {
                
                guard let roomDict = dict["room"] as? [String : NSObject] else {return}
                //组装数据
                if roomDict["room_id"] is  NSNull {
                    continue
                }
          
                let anchor = AnchorModel(dict: roomDict)
                self.dataGroup.anchors.append(anchor)
                
            }
            finishCallback()
        }
    }
     
    func requestData(_ finishCallback : @escaping () -> ()) {
        //1.申请首页滑动scrollView数据
        NetworkTools.requestData(.get, URLString: slideRec) { (result) in
                //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in dataArray {
              
                let cycleModel  = CycleModel(dict: dict)
                self.cycleModels.append(cycleModel)
//                print(cycleModel.pic_url)
            }

            finishCallback()
        }
    }
}
