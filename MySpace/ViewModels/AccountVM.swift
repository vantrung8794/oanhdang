//
//  AccountVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/17/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import Moya
import RxCocoa

struct SettingItem {
    var title: String?
    var value: String?
    var isOn: Bool?
}

struct UserInfo {
    var avatar: UIImage?
    var name: String?
    var currentPackage: String?
}

class AccountVM: BaseVM {
    var listSettings = BehaviorRelay<[SettingItem]>(value: [])
    var userInfo = BehaviorRelay<UserInfo>(value: UserInfo(avatar: UIImage(named: "avatar1"), name: StaticVM.userInfo.value?.username ?? "", currentPackage: "\(StaticVM.userInfo.value?.package_name ?? "") (\(StaticVM.userInfo.value?.package_data ?? 0)MB)"))
    
    func initSettings() {
        listSettings.accept([
            SettingItem(title: "Số điện thoại", value: userInfo.value.name, isOn: nil),
//            SettingItem(title: "Nhận thông báo", value: nil, isOn: true),
            SettingItem(title: "Đổi mật khẩu", value: nil, isOn: nil)
        ])
    }
}
