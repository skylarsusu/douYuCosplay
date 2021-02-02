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
    
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            //设置pageView的个数
            pageView.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
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
        return (cycleModels?.count ?? 0) * 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendCycleCellID, for: indexPath) as! RecommendCycleCell
        
        cell.cycleModel = cycleModels![indexPath.row % cycleModels!.count]

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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}
extension RecommendCycleView {
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
           let currentOffsetX = collectionView.contentOffset.x

           let offsetX = currentOffsetX + collectionView.bounds.width
           collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
