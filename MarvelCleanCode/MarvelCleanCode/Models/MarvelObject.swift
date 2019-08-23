//
//  MarvelObject.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

struct MarvelObject: Codable {
    let data: CharacterList?
}

struct CharacterList: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    var data: [Character]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case data = "results"
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let resultDescription: String
    let thumbnail: Thumbnail?
    let comics: Comics?
    let series: Comics?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, comics, series
    }
}

struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ComicsType {
    case comics
    case series
}

struct Comics: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    
    enum CodingKeys: String, CodingKey {
        case available, returned
        case collectionURI
        case items
    }
}

struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI, name
    }
}
