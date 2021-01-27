//
//  MainViewController.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/27.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor.white
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Flollow")
        addChildVC("Profile")
     
    }
    
    fileprivate func addChildVC(_ storyName : String) {
        //通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2.将childvc作为子控制器
        addChild(childVC)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
