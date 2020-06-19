//
//  SignUpVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/19/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

class SignUpVM: BaseVM {
    
    var userName = BehaviorRelay<String?>(value: nil)
    
    func signup(inVC vc: BaseVC, username: String, password: String){
        var input: [String: String] = [:]
        input["username"] = username
        input["password"] = password
        AppUtils.hideLoading(inVC: vc, false)
        let target = MultiTarget(AuthService.signup(params: input))

        Network.request(class: SignupModel.self, target: target, vc: vc, checkTokenExp: false, success: { [unowned self] obj in
            self.userName.accept(obj.username)
        })
    }
}
