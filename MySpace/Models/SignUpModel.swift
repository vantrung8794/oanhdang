//
//  SignUpModel.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/19/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper


final class LoginModel: Mappable{
    var username: String?
    var token: String?
    
    func mapping(map: Map) {
        username <- map["username"]
        token <- map["token"]
    }

    init?(map: Map) {}
}
