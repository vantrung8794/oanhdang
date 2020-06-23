//
//  FilesService.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/21/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import Foundation
import Moya

enum FilesService {
    case getHistory
    case getCountData
    case uploadImages(files: [Data], fileName: String)
    case deleteFile(fileName: String)
    case getListBucket
}

extension FilesService: TargetType{
    var path: String {
        switch self {
        case .getHistory:
            return "/gethistory"
        case .getCountData:
            return "/getcountdata"
        case .uploadImages(_, _):
            return "/upload"
        case .deleteFile(let fileName):
            return "/deletefile/\(fileName)"
        case .getListBucket:
            return "/getlistbucket"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHistory, .getCountData, .getListBucket:
            return .get
        case .uploadImages:
            return .post
        case .deleteFile:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case  .getHistory, .getCountData, .deleteFile, .getListBucket:
            return .requestPlain
        case let .uploadImages(files, fileName):
            var multipartData = [MultipartFormData]()
            for (_, value) in files.enumerated() {
                multipartData.append(MultipartFormData(provider: .data(value), name: "file", fileName: fileName, mimeType: "image/jpeg"))
            }
            return .uploadMultipart(multipartData)

        }
    }
}

