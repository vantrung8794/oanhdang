//
//  SignUpVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/19/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC {
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPass: UITextField!
    
    let vm = SignUpVM()
    var didSuccess: ((_ username: String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initUI() {
        super.initUI()
        self.title = "Đăng ký tài khoản"
    }
    
    override func bindData() {
        super.bindData()
        vm.userName.filter{$0 != nil}.subscribe(onNext: {username in
            AlertBuilder()
            .setTitle("Đăng ký thành công")
            .setSubText("Đăng ký tài khoản thành công!")
                .setAction1(withTitle: "Đóng") {
                    self.navigationController?.popViewController(animated: true)
                    if let success = self.didSuccess {
                        success(username ?? "")
                    }
                   
            }.show()
            }).disposed(by: disposeBag)
    }

    @IBAction func signupAction(_ sender: Any) {
        self.view.endEditing(true)
        if tfUserName.text!.trimed.isEmpty || tfPassword.text!.trimed.isEmpty {
            AppUtils.showMsg(inVC: self, "Tài khoản và mật khẩu không hợp lệ")
            return
        }
        
        vm.signup(inVC: self, username: tfUserName.text!.trimed, password: tfPassword.text!.trimed)
    }
}
