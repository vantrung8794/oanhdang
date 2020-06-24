//
//  FilesListVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class FilesListVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    let vm = FilesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicCell.self)
        StaticVM.listOtherFiles.subscribe(onNext: {lst in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.isDeleteSuccess.filter{$0}.subscribe(onNext: { _ in
            StaticVM.getListBucket(inVC: self)
        }).disposed(by: disposeBag)
    }
}

extension FilesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticVM.listOtherFiles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(StaticVM.listOtherFiles.value[indexPath.row])
        cell.didDelete = {
            AlertBuilder()
                .setTitle("Đăng xuất")
                .setSubText("Bạn có chắc chắn muốn xoá \(StaticVM.listOtherFiles.value[indexPath.row].file_name ?? "")?")
                .setAction1(withTitle: "Đồng ý") {
                    self.vm.deleteFile(inVC: self, fileName: StaticVM.listOtherFiles.value[indexPath.row].file_name ?? "")
            }
            .setAction2(withTitle: "Huỷ") {
                
            }.show()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: StaticVM.listOtherFiles.value[indexPath.row].file_url ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
