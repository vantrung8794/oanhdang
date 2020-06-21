//
//  BaseService.swift
//  MoyaGitHub
//
//  Created by TrungNV on 2/3/20.
//  Copyright © 2020 trungnv. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

public extension TargetType {
    var baseURL: URL {
        return URL(string: URLs.localURL)!
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        var header = ["Content-type": "application/json"]
        if let token = StaticValues.userLogin?.token {
            header["Authorization"] = "Bearer " + token
        }

        return header
    }
}


