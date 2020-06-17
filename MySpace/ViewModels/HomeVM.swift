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

enum TransferType {
    case Download
    case Upload
}

enum ItemType {
    case Image
    case Video
    case Music
}

struct HistoryItem {
    var type: ItemType?
    var name: String?
    var url: String?
    var transferType: TransferType?
}

class HomeVM: BaseVM {
    let HeightOfCell: CGFloat = 45.0
    var listHistoryItems = BehaviorRelay<[HistoryItem]>(value: [])
    
    func initDataList() {
        listHistoryItems.accept([
            HistoryItem(type: .Image, name: "MyLove.jpg", url: nil, transferType: .Download),
            HistoryItem(type: .Music, name: "Mẹ tôi.mp3", url: nil, transferType: .Upload),
            HistoryItem(type: .Music, name: "Chuyện tình tôi.mp3", url: nil, transferType: .Download),
            HistoryItem(type: .Video, name: "My Life.mp4", url: nil, transferType: .Upload)
        ])
    }
}
