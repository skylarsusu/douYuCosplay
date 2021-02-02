//
//  RecommendNoticeView.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/1.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

private let kRecommendNoticeCellID = "kRecommendNoticeCellID"

class RecommendNoticeView: UIView {
    
    //定义属性
    var cycleTimer : Timer?
    var noticeModels : [NoticeModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (noticeModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self  //设置代理
//        collectionView.scrollsToTop = false
//        collectionView.automaticallyAdjustsScrollViewInsets = NO;
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentOffset = CGPoint(x: 0, y: 0)

        collectionView.register(UINib(nibName: "CollectionHeaderCell", bundle: nil), forCellWithReuseIdentifier: kRecommendNoticeCellID)
        
        return collectionView
    
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
//        self.backgroundColor = UIColor.red
        //搭建视图
        setupUI()
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}

extension RecommendNoticeView {
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = bounds
    }
}


extension RecommendNoticeView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (noticeModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNoticeCellID, for: indexPath) as! CollectionHeaderCell
        
//        cell.backgroundColor = UIColor.red
        cell.noticeModel = noticeModels![indexPath.row % noticeModels!.count]

        return cell
    }
    
}

extension RecommendNoticeView : UICollectionViewDelegateFlowLayout {

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension RecommendNoticeView {
    fileprivate func addCycleTimer() {
           cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
       }
       
       fileprivate func removeCycleTimer() {
           cycleTimer?.invalidate() // 从运行循环中移除
           cycleTimer = nil
       }
       
       @objc fileprivate func scrollToNext() {
           // 1.获取滚动的偏移量
           let currentOffsetY = collectionView.contentOffset.y

           let offsetY = currentOffsetY + collectionView.bounds.height
//        if offsetY == CGFloat(150) {
////            offsetY = 50
//            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//        } else {
           // 2.滚动该位置
//           let offsetX = CGFloat(currentIndex) * collectionView.frame.width
//           collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
           collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
//        }
       }
}
