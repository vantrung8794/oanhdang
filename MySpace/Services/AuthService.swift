//
//  AuthService.swift
//  Tecomen
//
//  Created by TrungNV on 4/4/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import Foundation
import Moya

enum AuthService {
    case signup(params: [String: String])
    case login(params: [String: String])
}

extension AuthService: TargetType{
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        }
    }

    var task: Task {
        switch self {
        case  let .login(params), let .signup(params):
            var multipartData = [MultipartFormData]()
            for (key, value) in params {
                let formData = MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
                multipartData.append(formData)
            }
            return .uploadMultipart(multipartData)
        }
    }
}
