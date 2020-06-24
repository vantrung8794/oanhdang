//
//  UserService.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/24/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case getUserInfo
}

extension UserService: TargetType{
    var path: String {
        switch self {
        case .getUserInfo:
            return "/getuserinfo"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getUserInfo:
            return .requestPlain
        }
    }
}
