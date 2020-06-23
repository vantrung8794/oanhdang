//
//  FileVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import Moya
import RxSwift

struct CustomFile {
    var url: String?
    var name: String?
}

class FilesVM: BaseVM {
    var isDeleteSuccess = BehaviorRelay<Bool>(value: false)
    func deleteFile(inVC vc: BaseVC, fileName: String){
           AppUtils.hideLoading(inVC: vc, false)
           let target = MultiTarget(FilesService.deleteFile(fileName: fileName))
           Network.request(class: SuccessModel.self, target: target, vc: vc, success: { [unowned self] (obj) in
               self.isDeleteSuccess.accept(true)
           })
       }
}

