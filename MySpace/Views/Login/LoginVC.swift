//
//  LoginVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/14/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    let vm = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindData() {
        super.bindData()
        vm.isLoginSuccess.filter{$0}.subscribe(onNext: {isOk in
            NavigationHelper.setRoot(withVC: MainTabbarVC())
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupGradientBackground() {
    }
    
    @IBAction func loginAction(_ sender: Any) {
      vm.login(inVC: self, username: tfUsername.text!, password: tfPassword.text!)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
       
        let signupVC = SignUpVC()
        signupVC.didSuccess = { username in
            self.tfUsername.text = username
        }
        self.navigationController?.pushViewController(signupVC, animated: true)
        
    }
}
