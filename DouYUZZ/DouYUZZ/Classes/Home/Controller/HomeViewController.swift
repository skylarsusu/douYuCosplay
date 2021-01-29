//
//  HomeViewController.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/27.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit


private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    //mark - 上方titleView
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kStatukNavigationBarHsBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.yellow
        titleView.delegate  = self
        return titleView
    }()
    //mark 中间内容
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kStatukNavigationBarHsBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kStatukNavigationBarHsBarH - kTitleViewH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        let cotentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        cotentView.delegate = self
        
        return cotentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
}

extension HomeViewController {
    private func setupUI() {
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加内容ContentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        //1.设置左侧的item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //2.设置右侧的item
        let size = CGSize(width: 30, height: 30)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}

//遵守协议 PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func slidePageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, target: Int) {
        pageTitleView.setTitleViewWithProgress(progress, sourceIndex: sourceIndex, targetIndex: target)
    }
}
