//
//  StaticVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/22/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

class StaticVM: BaseVM {
    static var listImages = BehaviorRelay<[FileModel]>(value: [])
    static var listMusics = BehaviorRelay<[FileModel]>(value: [])
    static var listOtherFiles = BehaviorRelay<[FileModel]>(value: [])
    static var userInfo = BehaviorRelay<UserInfoModel?>(value: nil)
    
    static func getListBucket(inVC vc: BaseVC){
        let target = MultiTarget(FilesService.getListBucket)
        Network.request(class: HistoryModel.self, target: target, vc: vc, success: {(obj) in
            listImages.accept(obj.files.filter{$0.type == .Image})
            listMusics.accept(obj.files.filter{$0.type == .Music})
            listOtherFiles.accept(obj.files.filter{$0.type == .File})
        })
    }
    
    static func getUserInfo(inVC vc: BaseVC){
        let target = MultiTarget(UserService.getUserInfo)
        Network.request(class: UserModel.self, target: target, vc: vc, success: {(obj) in
            userInfo.accept(obj.userinfo)
        })
    }
}
