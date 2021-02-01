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
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderCellID = "kHeaderCellID"

let kNormalItemW = (kScreenW - 3 * KItemMargin)/2
let kNormalItemH = kNormalItemW
let kPrettyItemH = kNormalItemW * 4 / 3



class RecommendViewController: UIViewController {
    
    //Mark-懒加载
    fileprivate lazy var RecommendVM : RecommendViewModel = RecommendViewModel()

    //上方翻页图片
    fileprivate lazy var recycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView(frame: CGRect(x: 0, y: -(kCycleViewH + kHeaderViewH), width: kScreenW, height: kCycleViewH))
       
        return cycleView
    }()
    
    //下方滚动预告
    fileprivate lazy var noticeView : RecommendNoticeView = {
        let noticeView = RecommendNoticeView(frame: CGRect(x: 0, y:  -kHeaderViewH , width: kScreenW, height: kHeaderViewH))
        return noticeView
    }()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //组装UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
//        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
//        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //视图布局
        setupUI()
        
        //网络请求
        loadData()
        // Do any additional setup after loading the view.
    }
    
}

extension RecommendViewController {
    private func loadData() {
        RecommendVM.requestMainData {
            self.collectionView.reloadData()
        }
        RecommendVM.requestData {
            self.recycleView.cycleModels = self.RecommendVM.cycleModels
        }
        RecommendVM.requestNoticeData {
            self.noticeView.noticeModels = self.RecommendVM.notices
        }

    }
}

extension RecommendViewController {
    
    private func setupUI() {
        
        self.view .addSubview(collectionView)
        //将cycleView加到collectionView
        collectionView .addSubview(recycleView)
        collectionView.addSubview(noticeView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kHeaderViewH, left: 0, bottom: 0, right: 0)
        
        
    }
    
}

extension RecommendViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchorModel = self.RecommendVM.dataGroup.anchors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.RecommendVM.dataGroup.anchors.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
 
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
