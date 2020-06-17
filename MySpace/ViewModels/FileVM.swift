//
//  FileVM.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct CustomFile {
    var url: String?
    var name: String?
}

class FilesVM: BaseVM {
    var listFile = BehaviorRelay<[CustomFile]>(value: [])
    
    func initFiles() {
        listFile.accept([
            CustomFile(url: "", name: "ho_so_Ca_nha.pdf"),
            CustomFile(url: "", name: "my_files.zip"),
            CustomFile(url: "", name: "cv_oanh_Dang.docx")
            
        ])
    }
}

