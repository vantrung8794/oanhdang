//
//  MusicVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct CustomMusic {
    var url: String?
    var isPlay: Bool = false
    var imageUrl: String?
    var name: String?
}

class MusicVM: BaseVM {
    var listMusic = BehaviorRelay<[CustomMusic]>(value: [])
    
    func initMusic() {
        listMusic.accept([
            CustomMusic(url: "music1", isPlay: false, imageUrl: nil, name: "Nhà em lưng chừng núi"),
            CustomMusic(url: "music2", isPlay: false, imageUrl: nil, name: "Mẹ tôi"),
            CustomMusic(url: "music3", isPlay: false, imageUrl: nil, name: "Gánh hàng rong"),
            CustomMusic(url: "music4", isPlay: false, imageUrl: nil, name: "Ngày mai sẽ khác"),
        ])
    }
}
