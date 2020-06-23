//
//  HomeVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/14/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Photos

class HomeVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCountdata: UILabel!
    
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
        lblUserName.text = StaticValues.userLogin?.username
    }
    
    override func setupGradientBackground() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.getCountData(inVC: self)
        vm.getHistory(inVC: self)
        FileContaintsVM.getListBucket(inVC: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func bindData() {
        super.bindData()
        vm.listHistoryItems.subscribe(onNext: {lst in
            self.tableView.reloadData()
            self.heightOfTableView.constant = CGFloat(lst.count) * self.vm.HeightOfCell
            }).disposed(by: disposeBag)
        
        vm.countData.subscribe(onNext: { countData in
            UIView.animate(withDuration: 1) {
                let count = countData / 1024 / 1024
                let roundCount =  Double(round(100*count)/100)
                self.progressBar.value = CGFloat(roundCount)
                self.lblCountdata.text = "Data sử dụng \(roundCount)MB /100MB"
            }
        }).disposed(by: disposeBag)
        
        vm.isUploadSuccess.filter{$0}.subscribe(onNext: { _ in
            AlertBuilder()
            .setTitle("Upload")
            .setSubText("Tải lên thành công!")
                .setAction1(withTitle: "Đóng") {
                    self.vm.getCountData(inVC: self)
                    self.vm.getHistory(inVC: self)
                    FileContaintsVM.getListBucket(inVC: self)
            }.show()
        }).disposed(by: disposeBag)
        
        vm.isDeleteSuccess.filter{$0}.subscribe(onNext: { _ in
            AlertBuilder()
            .setTitle("Xoá file")
            .setSubText("Xoá file thành công!")
                .setAction1(withTitle: "Đóng") {
                    self.vm.getCountData(inVC: self)
                    self.vm.getHistory(inVC: self)
                    FileContaintsVM.getListBucket(inVC: self)
            }.show()
        }).disposed(by: disposeBag)
    }
    
    @IBAction func choseFileToUploadAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.listHistoryItems.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(vm.listHistoryItems.value[indexPath.row])
        cell.chooseAction = {
            AlertBuilder()
                .setTitle("Đăng xuất")
                .setSubText("Bạn có chắc chắn muốn xoá \(self.vm.listHistoryItems.value[indexPath.row].file_name ?? "")?")
                .setAction1(withTitle: "Đồng ý") {
                    self.vm.deleteFile(inVC: self, fileName: self.vm.listHistoryItems.value[indexPath.row].file_name ?? "")
            }
            .setAction2(withTitle: "Huỷ") {
                
            }.show()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.HeightOfCell
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
//        let newImage = image.resize()
        let name = (StaticValues.userLogin?.username ?? "") + "_Image_" +  String(Date().timeIntervalSince1970)
        vm.uploadImages(inVC: self, withImage: image, fileName: name)
    }
}

extension HomeVC: UIActionSheetDelegate {
    
}
