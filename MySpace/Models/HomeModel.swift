//
//  HomeModel.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/21/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper


enum ItemType {
    case Image
    case Music
    case File
}

final class FileModel: Mappable {
    var file_name: String? = nil {
        didSet {
            if let n = file_name {
                if n.contains("jpg") || n.contains("png") || n.contains("jpeg") {
                    self.type = .Image
                }else if n.contains("mp3") {
                    self.type = .Music
                }else{
                    self.type = .File
                }
            }
        }
    }
    
    var file_size: CGFloat?
    var file_url: String?
    var created_date: String?
    var user_name: String?
    var type: ItemType?
    
    func mapping(map: Map) {
        file_name <- map["file_name"]
        file_size <- map["file_size"]
        file_url <- map["file_url"]
        created_date <- map["created_date"]
        user_name <- map["user_name"]
    }

    init?(map: Map) {}
}

final class HistoryModel: Mappable {
    var files = [FileModel]()
    func mapping(map: Map) {
        files <- map["files"]
    }
    init?(map: Map) {}
}

final class CountDataModel: Mappable {
    var countdata: CGFloat = 0
    func mapping(map: Map) {
        countdata <- map["countdata"]
    }
    init?(map: Map) {}
}

final class SuccessModel: Mappable {
    var status: CGFloat = 0
    func mapping(map: Map) {
        status <- map["status"]
    }
    init?(map: Map) {}
}
