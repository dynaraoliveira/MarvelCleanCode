//
//  ComicsObject.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/07/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

struct ComicsSeriesObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ComicsSeriesObjectData
}

struct ComicsSeriesObjectData: Codable {
    let offset, limit, total, count: Int
    let results: [ComicsSeriesResult]
}

struct ComicsSeriesResult: Codable {
    let thumbnail: Thumbnail
}
