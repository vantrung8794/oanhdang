//
//  MusicVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import Moya
import RxSwift

struct CustomMusic {
    var url: String?
    var isPlay: Bool = false
    var imageUrl: String?
    var name: String?
}

class MusicVM: BaseVM {
    var listMusic = BehaviorRelay<[CustomMusic]>(value: [])
    var isDeleteSuccess = BehaviorRelay<Bool>(value: false)
    
    func initMusic() {
        listMusic.accept([
            CustomMusic(url: "music1", isPlay: false, imageUrl: nil, name: "Nhà em lưng chừng núi"),
            CustomMusic(url: "music2", isPlay: false, imageUrl: nil, name: "Mẹ tôi"),
            CustomMusic(url: "music3", isPlay: false, imageUrl: nil, name: "Gánh hàng rong"),
            CustomMusic(url: "music4", isPlay: false, imageUrl: nil, name: "Ngày mai sẽ khác"),
        ])
    }
    
    func deleteFile(inVC vc: BaseVC, fileName: String){
        AppUtils.hideLoading(inVC: vc, false)
        let target = MultiTarget(FilesService.deleteFile(fileName: fileName))
        Network.request(class: SuccessModel.self, target: target, vc: vc, success: { [unowned self] (obj) in
            self.isDeleteSuccess.accept(true)
        })
    }
}
