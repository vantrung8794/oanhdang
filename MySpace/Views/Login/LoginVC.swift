//
//  LoginVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/14/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let homeVC = MainTabbarVC()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
}
