//
//  LoginModel.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import ObjectMapper


final class SignupModel: Mappable{
    var username: String?
    
    func mapping(map: Map) {
        username <- map["username"]
    }

    init?(map: Map) {}
}
