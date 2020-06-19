//
//  NetWork.swift
//  MoyaGitHub
//
//  Created by TrungNV on 2/3/20.
//  Copyright © 2020 trungnv. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

struct Network {
    static let provider = MoyaProvider<MultiTarget>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    static func request<T: Mappable>(class: T.Type,
                                     target: MultiTarget,
                                     vc viewcontroller: BaseVC? = nil,
                                     isCustomError: Bool = false,
                                     checkTokenExp: Bool = true,
                                     success successCallback: @escaping (T) -> Void = {_ in },
                                     error errorCallback: @escaping  (_ description: String) -> Void = {_ in },
                                     failure failureCallback: @escaping (MoyaError) -> Void = {_ in },
                                     notFound notFoundCallback: @escaping (Response) -> Void = {_ in }
    ) {
        provider.request(target) { result in
            var msg = ""
            if let vc = viewcontroller {
                AppUtils.hideLoading(inVC: vc, true)
            }
            
            switch result {
            case let .success(response):
                do {
                    if response.statusCode <= 299 && response.statusCode >= 200 {
                        if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any], let object = T(JSON: json) {
                            successCallback(object)
                        }else {
                            msg = "Lỗi không chuyển đổi được kiểu dữ liệu"
                            if isCustomError{
                                errorCallback(msg)
                            }
                        }
                    }else {
                        msg = response.debugDescription
                        if isCustomError{
                            errorCallback(msg)
                        }
                    }
                    
                } catch let error {
                    msg = error.localizedDescription
                    if isCustomError{
                        errorCallback(msg)
                    }
                }
            case let .failure(error):
                msg = error.errorDescription.value()
                if isCustomError {
                    failureCallback(error)
                }
            }
            if let vc = viewcontroller, !isCustomError, !msg.trimed.isEmpty {
                AppUtils.showMsg(inVC: vc, msg)
            }
        }
    }
}
