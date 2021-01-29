//
//  RecommendViewController.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/28.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

private let KItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderCellID = "kHeaderCellID"

let kNormalItemW = (kScreenW - 3 * KItemMargin)/2
let kNormalItemH = kNormalItemW * 3 / 4

class RecommendViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //组装UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
      
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //视图布局
        setupUI()
        // Do any additional setup after loading the view.
    }
    
}

extension RecommendViewController {
    
    private func setupUI() {
        self.view .addSubview(collectionView)
    }
    
}

extension RecommendViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderCellID, for: indexPath)
        
        headerView.backgroundColor = UIColor.gray
        
        return headerView
    }
    
}
