//
//  ApiProvider.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation
import CryptoSwift

struct ApiProvider {
    static private let privateKey = Bundle.main.object(forInfoDictionaryKey: "Private key") as! String
    static private let publicKey = Bundle.main.object(forInfoDictionaryKey: "Public key") as! String
    static private let urlCharacters = "https://gateway.marvel.com/v1/public/characters"
    static let limit = 20
    
    static func getCredencial(offset: Int?, limit: Int?, orderBy: Bool?) -> String {
        let timestamp = Date().timeIntervalSince1970.description
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        
        var authParams = ["ts": timestamp,
                          "apikey": publicKey,
                          "hash": hash]
        
        if (orderBy ?? false) { authParams["orderBy"] = "name" }
        if (limit != nil) { authParams["limit"] = String(limit ?? 20) }
        if (offset != nil) { authParams["offset"] = String(offset ?? 0) }
        
        return authParams.queryString ?? ""
    }
    
    static func marvelObjectUrl(offset: Int?) -> String {
        return "\(urlCharacters)?" +
            getCredencial(offset: offset, limit: limit, orderBy: true)
    }
    
    static func comicsSeriesUrl(url: String) -> String {
        return "\(url)?" +
            getCredencial(offset: nil, limit: nil, orderBy: nil)
    }
    
}
