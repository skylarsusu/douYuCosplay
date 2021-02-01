//
//  RecommendCycleCell.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/31.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageVIew: UIImageView!
    //定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageVIew.kf.setImage(with: iconUrl)
          
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
