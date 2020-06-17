//
//  HistoryItemCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/15/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class HistoryItemCell: BaseTableCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: HistoryItem) {
        switch data.type {
        case .Image:
            img.image = UIImage(named: "ic_image")
        case .Video:
            img.image = UIImage(named: "ic_video")
        case .Music:
            img.image = UIImage(named: "ic_music")
        default:
            img.image = UIImage()
        }
        
        lblTitle.text = data.name ?? ""
    }
}
