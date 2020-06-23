//
//  HomeVM.swift
//  TTCEasy
//
//  Created by TrungNV on 6/5/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import Foundation
import RxCocoa
import Moya

class HomeVM: BaseVM {
    let HeightOfCell: CGFloat = 45.0
    var listHistoryItems = BehaviorRelay<[FileModel]>(value: [])
    var countData = BehaviorRelay<CGFloat>(value: 0.0)
    var isUploadSuccess = BehaviorRelay<Bool>(value: false)
    var isDeleteSuccess = BehaviorRelay<Bool>(value: false)
    
    func getHistory(inVC vc: BaseVC){
        let target = MultiTarget(FilesService.getHistory)
        Network.request(class: HistoryModel.self, target: target, vc: vc, success: { [unowned self] (obj) in
            self.listHistoryItems.accept(obj.files)
        })
    }
    
    func getCountData(inVC vc: BaseVC){
        let target = MultiTarget(FilesService.getCountData)
        Network.request(class: CountDataModel.self, target: target, vc: vc, success: { [unowned self] (obj) in
            self.countData.accept(obj.countdata)
        })
    }
    
    func uploadImages(inVC vc: BaseVC, withImage image: UIImage?, fileName: String){
        guard let img = image else {
            return
        }
        let data = img.jpegData(compressionQuality: 0.9)
        let imgKBSize = Double(data?.count ?? 0) / 1024.0
        
        if imgKBSize <= 0 || imgKBSize > 10000 {
            AppUtils.showMsg(inVC: vc, "Dung lượng ảnh không được vượt quá 10MB")
        }
        
        AppUtils.hideLoading(inVC: vc, false)
        var name = fileName
        if !fileName.contains(".jpg") && !fileName.contains(".jpeg") {
            name += ".jpg"
        }
        let target = MultiTarget(FilesService.uploadImages(files: [data ?? Data()], fileName: name))
        Network.request(class: SuccessModel.self, target: target, vc: vc, success: { obj in
            self.isUploadSuccess.accept(true)
        })
    }
    
    func deleteFile(inVC vc: BaseVC, fileName: String){
        AppUtils.hideLoading(inVC: vc, false)
        let target = MultiTarget(FilesService.deleteFile(fileName: fileName))
        Network.request(class: SuccessModel.self, target: target, vc: vc, success: { [unowned self] (obj) in
            self.isDeleteSuccess.accept(true)
        })
    }
}
