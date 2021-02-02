//
//  RecommendGameCell.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/2.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendGameCell: UICollectionViewCell {

    @IBOutlet weak var img_url: UIImageView!
    @IBOutlet weak var tag_text: UILabel!
    var gameModel : GameModel? {
        didSet {
            tag_text.text = gameModel?.tag_name
            if let iconUrl = URL(string: gameModel?.icon_url ?? "") {
                img_url.kf.setImage(with: iconUrl)
            } else {
                img_url.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
