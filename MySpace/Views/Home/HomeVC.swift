//
//  HomeVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/14/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class HomeVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    
    let vm = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initUI() {
        super.initUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryItemCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            self.progressBar.value = 50.0
        }
    }
    
    override func bindData() {
        super.bindData()
        vm.listHistoryItems.subscribe(onNext: {lst in
            self.tableView.reloadData()
            self.heightOfTableView.constant = CGFloat(lst.count) * self.vm.HeightOfCell
            }).disposed(by: disposeBag)
    }
    
    override func initData() {
        super.initData()
        vm.initDataList()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.listHistoryItems.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(vm.listHistoryItems.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.HeightOfCell
    }
}
