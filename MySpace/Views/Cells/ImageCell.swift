//
//  ImageCell.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: BaseCollectionCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: CustomImage) {
        let url = URL(string: data.url ?? "")
        imgView.kf.setImage(with: url)
    }

}
