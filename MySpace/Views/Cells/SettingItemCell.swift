//
//  SettingItemCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/17/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class SettingItemCell: BaseTableCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var switchView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ data: SettingItem) {
        self.lblTitle.text = data.title
        if let value = data.value {
            self.lblContent.isHidden = false
            self.lblContent.text = value
        }else{
            self.lblContent.isHidden = true
        }
        
        if let isOn = data.isOn {
            switchView.isHidden = false
            switchState.isOn = isOn
        }else{
            switchView.isHidden = true
        }
    }
}
