//
//  UIBarButtonItem-Extention.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/27.
//  Copyright © 2021 苏宝敬. All rights reserved.
//


import UIKit

extension UIBarButtonItem {
    
    /*类方法
    class func  createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //使用便利构造函数: 1.convenience开头2.在构造函数中必须调用一个设计的构造函数(self)
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        //1.创建UIButton
        let btn = UIButton()
        //设置normal图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        //3.设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
