//
//  LogoutCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/17/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class LogoutCell: BaseTableCell {
    
    var didLogout : (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didLogoutAction(_ sender: Any) {
        if let logout = didLogout {
            logout()
        }
    }
    
}
