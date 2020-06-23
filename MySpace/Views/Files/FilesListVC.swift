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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicCell.self)
        FileContaintsVM.listOtherFiles.subscribe(onNext: {lst in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension FilesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileContaintsVM.listOtherFiles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(FileContaintsVM.listOtherFiles.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
}
