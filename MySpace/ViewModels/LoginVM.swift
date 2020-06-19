//
//  LoginVM.swift
//  TTCEasy
//
//  Created by TrungNV on 6/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

final class LoginVM: BaseVM {
    
    var isLoginSuccess = BehaviorRelay<Bool>(value: false)

    func login(inVC vc: BaseVC, username: String, password: String){
        var input: [String: String] = [:]
        input["username"] = username
        input["password"] = password
        AppUtils.hideLoading(inVC: vc, false)
        let target = MultiTarget(AuthService.login(params: input))
        Network.request(class: LoginModel.self, target: target, vc: vc, checkTokenExp: false, success: { [unowned self] (obj) in
            StaticValues.userLogin = obj
            self.isLoginSuccess.accept(true)
        })
    }
}
