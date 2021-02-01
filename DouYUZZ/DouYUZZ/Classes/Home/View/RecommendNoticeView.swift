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
    
    var noticeModels : [NoticeModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (noticeModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
        }
    }
    
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
//        collectionView.delegate = self  //设置代理
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
        return noticeModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNoticeCellID, for: indexPath) as! CollectionHeaderCell
        
//        cell.backgroundColor = UIColor.red
        cell.noticeModel = noticeModels![indexPath.row]

        return cell
    }
    
}

//extension RecommendNoticeView : UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: kScreenW, height: kNoticeViewH)
//    }
//}

