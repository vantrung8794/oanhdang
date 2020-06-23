//
//  ImageVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SKPhotoBrowser
import Moya

struct CustomImage {
    var url: String?
}

class ImageVM: BaseVM {
    var listImages = BehaviorRelay<[CustomImage]>(value: [])
    var images = [SKPhoto]()
    var isDeleteSuccess = BehaviorRelay<Bool>(value: false)
    
    func initImages() {
        listImages.accept([
                CustomImage(url: "https://i.ibb.co/R9hrBQF/5d3a66f962710e25dc99ffa3.jpg"),
                CustomImage(url: "https://i.ibb.co/sQcvn2x/83d44da53200008bc5f3e94c512e2e15.jpg"),
                CustomImage(url: "https://i.ibb.co/VvHXTNz/4891210-Cover-T.jpg"),
                CustomImage(url: "https://i.ibb.co/vcx9jk3/avatar.jpg"),
                CustomImage(url: "https://i.ibb.co/nwZkNxh/dia-diem-du-lich-sapa-1.jpg"),
                CustomImage(url: "https://i.ibb.co/0XqLGPW/download-1.jpg"),
                CustomImage(url: "https://i.ibb.co/WsnVbH8/download-2.jpg"),
                CustomImage(url: "https://i.ibb.co/mtZZPPp/download-3.jpg"),
                CustomImage(url: "https://i.ibb.co/jVPP06v/download-4.jpg"),
                CustomImage(url: "https://i.ibb.co/DG1qKXb/download-5.jpg"),
                CustomImage(url: "https://i.ibb.co/B6xS8mX/download.jpg"),
                CustomImage(url: "https://i.ibb.co/t3XbR7X/Pasted-27.jpg"),
                CustomImage(url: "https://i.ibb.co/FJVwnC4/tao-dang-chup-anh-bien-1-9f87c843d410480f82983a478d8c38bd.jpg"),
                CustomImage(url: "https://i.ibb.co/DMFfV7L/Tro-n-bo-nhu-ng-hi-nh-a-nh-e-p-girl-xinh-cho-ie-n-thoa-i.jpg"),
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
