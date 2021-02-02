//
//  RecommendGameView.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/2.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

private let kRecommendGameCellID = "kRecommendGameCellID"

let kGameMargin : CGFloat = 10
let kGameCellW : CGFloat = (kScreenW - kGameMargin * 2 ) / 5

class RecommendGameView: UIView {
    
    var gameModels : [GameModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
        }
    }

    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kGameCellW, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: kGameMargin, bottom: 0, right: kGameMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.bounces = false
        collectionView.dataSource = self
//        collectionView.delegate = self  //设置代理
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
  

        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kRecommendGameCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kRecommendGameCellID)
        
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

extension RecommendGameView {
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.frame = bounds
        
       
    }
}


extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendGameCellID, for: indexPath) as! RecommendGameCell
//        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.green
        cell.gameModel = gameModels![indexPath.row % gameModels!.count]

        return cell
    }
    
}

