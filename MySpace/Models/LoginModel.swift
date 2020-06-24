//
//  LoginModel.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import ObjectMapper


final class SignupModel: Mappable {
    var username: String?
    
    func mapping(map: Map) {
        username <- map["username"]
    }

    init?(map: Map) {}
}

final class UserModel: Mappable {
    var userinfo: UserInfoModel?
    
    func mapping(map: Map) {
        userinfo <- map["userinfo"]
    }

    init?(map: Map) {}
}

final class UserInfoModel: Mappable {
    var username: String?
    var password: String?
    var avatar_url: String?
    var full_name: String?
    var package_id: Int?
    var package_name: String?
    var package_cost: Int?
    var package_data: Int?
    
    func mapping(map: Map) {
        username <- map["username"]
        password <- map["password"]
        avatar_url <- map["avatar_url"]
        full_name <- map["full_name"]
        package_id <- map["package_id"]
        package_name <- map["package_name"]
        package_cost <- map["package_cost"]
        package_data <- map["package_data"]
    }

    init?(map: Map) {}
}
