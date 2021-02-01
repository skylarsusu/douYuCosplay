//
//  RecommendCycleView.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/29.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

private let kRecommendCycleCellID = "kRecommendCycleCellID"

class RecommendCycleView: UIView {
    
    var cycleModels : [CycleModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            //设置pageView的个数
            pageView.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
        }
    }
    
    fileprivate lazy var pageView : UIPageControl = {
        let pageView = UIPageControl(frame: CGRect(x: kScreenW-100, y: self.bounds.size.height - 50, width: 100, height: 50))
        pageView.currentPage = 0
//        pageView.backgroundColor = UIColor.gray
   
        return pageView
    }()

    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
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

        collectionView.register(UINib(nibName: "RecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kRecommendCycleCellID)
        
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

extension RecommendCycleView {
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.frame = bounds
        
        addSubview(pageView)
    }
}


extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendCycleCellID, for: indexPath) as! RecommendCycleCell
        
        cell.cycleModel = cycleModels![indexPath.row]

        return cell
    }
    
}

extension RecommendCycleView : UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageView.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: kScreenW, height: kCycleViewH)
    }
}
//extension RecommendCycleView : UICollectionViewDelegate {
//
//
////    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////      let page = floor(scrollView.contentOffset.x / self.bounds.width)
////          pageView.currentPage = Int(page)
////    }
//
//
//}
