//
//  MainTabbarVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/15/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController {

    class func getInstance() -> MainTabbarVC {
        return MainTabbarVC()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        configTabItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func configTabItem() {
        let homeVC = HomeVC()
        let filesVC = FilesVC()
        let accountVC = AccountVC()

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), tag: 0)
        filesVC.tabBarItem = UITabBarItem(title: "Files", image: UIImage(named: "ic_files"), tag: 1)
        accountVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(named: "ic_setting"), tag: 2)

        let tabBarList = [homeVC, filesVC, accountVC]
        viewControllers = tabBarList
    }
}
