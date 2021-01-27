//
//  HomeViewController.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/27.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
}

extension HomeViewController {
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //1.设置左侧的item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //2.设置右侧的item
        let size = CGSize(width: 30, height: 30)
        
        /**
            let historyBtn = UIButton()
             historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
             historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
             historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
             let historyItem = UIBarButtonItem(customView: historyBtn)
         
             
             let searchBtn = UIButton()
             searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
             searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
             searchBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
             let searchItem = UIBarButtonItem(customView: searchBtn)
             
             let qrcodeBtn = UIButton()
             qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
             qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
             qrcodeBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
             let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
         */
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
