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
    
    var chooseAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: FileModel) {
        switch data.type {
        case .Image:
            img.image = UIImage(named: "ic_image")
        case .File:
            img.image = UIImage(named: "ic_files")
        case .Music:
            img.image = UIImage(named: "ic_music")
        default:
            img.image = UIImage()
        }
        
        lblTitle.text = data.file_name ?? ""
    }
    @IBAction func didChooseAction(_ sender: Any) {
        if let choose = chooseAction {
            choose()
        }
    }
    
}
