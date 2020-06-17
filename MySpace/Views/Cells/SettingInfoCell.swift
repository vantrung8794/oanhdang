//
//  SettingInfoCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/17/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class SettingInfoCell: BaseTableCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgAvatar.cornerRadius = imgAvatar.frame.height / 2.0
        imgAvatar.clipsToBounds = true
    }
    
}
