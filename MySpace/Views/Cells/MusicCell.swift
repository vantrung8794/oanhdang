//
//  MusicCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class MusicCell: BaseTableCell {
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var didDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: CustomMusic) {
        if data.isPlay {
            imgType.image = UIImage.gif(name: "music_play")
        }else{
            imgType.image = UIImage(named: "ic_music")
        }
        lblTitle.text = data.name
    }
    
    func configCell(_ data: FileModel) {
        imgType.image = UIImage(named: "ic_files")
        lblTitle.text = data.file_name ?? ""
    }
    
    @IBAction func deleteActioon(_ sender: Any) {
        if let delete = didDelete {
            delete()
        }
    }
    
}
