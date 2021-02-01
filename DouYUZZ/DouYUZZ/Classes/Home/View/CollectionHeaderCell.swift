//
//  CollectionHeaderCell.swift
//  DouYUZZ
//
//  Created by 苏宝敬 on 2021/2/1.
//  Copyright © 2021 苏宝敬. All rights reserved.
//

import UIKit

class CollectionHeaderCell: UICollectionViewCell {

    
    @IBOutlet weak var sub_num_Label: UIButton!
    @IBOutlet weak var sub_num: UILabel!
    @IBOutlet weak var act_start_time: UILabel!
    @IBOutlet weak var act_name: UILabel!

    
    var noticeModel : NoticeModel? {
        didSet {
            act_name.text = noticeModel?.act_name
            let timeSta:TimeInterval = Double((noticeModel?.act_start_time)!)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yy HH:mm"
            let dateStr = dateFormatter.string(from: Date(timeIntervalSince1970: timeSta))
            act_start_time.text = dateStr
            sub_num.text = "\((noticeModel?.sub_num)!)" + "人预定"
            sub_num_Label.setTitle(noticeModel?.act_button_text, for: .normal)
            sub_num_Label.layer.borderColor = UIColor.orange.cgColor
            sub_num_Label.layer.borderWidth = 1
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        
    }
}
