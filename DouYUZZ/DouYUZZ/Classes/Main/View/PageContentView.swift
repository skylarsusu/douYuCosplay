//
//  PageContentView.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/27.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func slidePageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, target : Int)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //mark--懒加载CollectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self  //设置代理
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    //mark:- 定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置ui
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension PageContentView {
    private func setupUI() {
        //将所有的子控制器添加到付控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        //2.添加UICollectionView,用于在CEll中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//mark -UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[(indexPath as IndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}


//mark -UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
       //1.定义需要的数据
        var progress : CGFloat = 0
        var sourceIdex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIdex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIdex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 4.如果完全划过去
              if currentOffsetX - startOffsetX == scrollViewW {
                  progress = 1
                  targetIndex = sourceIdex
              }
        } else {//右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIdex = targetIndex + 1
             if sourceIdex >= childVcs.count {
                 sourceIdex = childVcs.count - 1
             }
        }
        
//        print("progress : \(progress) , sourceIdex : \(sourceIdex) ,targetIndex : \(targetIndex) ")
        delegate?.slidePageContentView(self, progress: progress, sourceIndex: sourceIdex, target: targetIndex)
        
    }
}
