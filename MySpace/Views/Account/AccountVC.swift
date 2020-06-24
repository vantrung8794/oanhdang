//
//  AccountVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/15/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class AccountVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    let vm = AccountVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingInfoCell.self)
        tableView.register(SettingItemCell.self)
        tableView.register(LogoutCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StaticVM.getUserInfo(inVC: self)
    }
    
    override func initData() {
        super.initData()
        vm.initSettings()
    }
    
    override func bindData() {
        super.bindData()
        StaticVM.userInfo.subscribe(onNext: { info in
            self.vm.userInfo.accept(UserInfo(avatar: UIImage(named: "avatar1"), name: info?.full_name ?? info?.username, currentPackage: "\(info?.package_name ?? "") (\(info?.package_data ?? 0)MB)"))
            var temp = self.vm.listSettings.value
            temp[0].value = info?.username
            self.vm.listSettings.accept(temp)
        }).disposed(by: disposeBag)
        
        vm.userInfo.subscribe(onNext: { info in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        vm.listSettings.subscribe(onNext: { list in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func setupGradientBackground() {
    }
}

extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return vm.listSettings.value.count
        }
        if section == 2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let cell: SettingInfoCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configCell(vm.userInfo.value)
            return cell
        }
        if section == 1 {
            let cell: SettingItemCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configCell(vm.listSettings.value[indexPath.row])
            return cell
        }
        if section == 2 {
            let cell: LogoutCell = tableView.dequeueReusableCell(for: indexPath)
            cell.didLogout = {
                AlertBuilder()
                    .setTitle("Đăng xuất")
                    .setSubText("Bạn có chắc chắn muốn đăng xuất?")
                    .setAction1(withTitle: "Đồng ý") {
                        NavigationHelper.setRoot(withVC: LoginVC())
                }
                .setAction2(withTitle: "Huỷ") {
                    
                }.show()
                
            }
            return cell
        }
        return UITableViewCell()
    }
}
