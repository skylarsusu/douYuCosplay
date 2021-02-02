//
//  CollectionNormalCell.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/1/29.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    
    @IBOutlet weak var onLineNumbet: UIButton!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var normalCellImage: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var online: UIButton!
    var anchorModel : AnchorModel? {
        didSet {
            let iconUrl = URL(string: anchorModel?.vertical_src ?? "")
            normalCellImage.kf.setImage(with: iconUrl)
            
            nickname.text = anchorModel?.nickname
            roomName.text = anchorModel?.room_name
            tagLabel.text = " " + anchorModel!.tagDes + " "
            tagLabel.layer.borderColor = UIColor.orange.cgColor
            tagLabel.layer.borderWidth = 1
            let online : String = "\(floor(Double((anchorModel?.online)!/10000)))" + "万"
            onLineNumbet.setTitle(online, for: .normal)
          
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
