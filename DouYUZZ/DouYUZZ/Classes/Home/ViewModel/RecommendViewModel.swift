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
    lazy var gameModels : [GameModel] = [GameModel]()
}
extension RecommendViewModel {
    
    func requestData(_ finishCallback : @escaping () -> ()) {
        let dispatch_group = DispatchGroup()
        dispatch_group.enter()
        //申请主要collection数据
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
            dispatch_group.leave()
        }
        
        dispatch_group.enter()
        //请求预定轮转数据
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
            dispatch_group.leave()
        }
        dispatch_group.enter()
        //请求推荐按钮数据
        NetworkTools.requestData(.get, URLString: cateList) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                let gameModel = GameModel(dict: dict)
                self.gameModels.append(gameModel)
            }
            let gameModel_first = GameModel()
            gameModel_first.tag_name = "全部"
            self.gameModels.insert(gameModel_first, at: 0)
            let gameModel_last = GameModel()
            gameModel_last.tag_name = "更多"
            self.gameModels.append(gameModel_last)
            dispatch_group.leave()
        }
        
        dispatch_group.notify(queue: DispatchQueue.main) {
            finishCallback()
        }
    }
    
    func requestSlideData(_ finishCallback : @escaping () -> ()) {
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

