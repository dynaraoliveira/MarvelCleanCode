//
//  MarvelObjectAPI.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class MarvelObjectAPI: MarvelObjectListStoreProtocol & CharacterDetailStoreProtocol {
    func fetchCharacter(offset: Int?, completionHandler: @escaping MarvelObjectCallback) {
        guard let url = URL(string: ApiProvider.marvelObjectUrl(offset: offset)) else {
            return
        }
        
        MarvelObjectApiProvider.fetchMarvelObject(url: url) { (result) in
            completionHandler(result)
        }
    }
    
    func fetchComicsSeriesObject(urlString: String, completionHandler: @escaping ComicsSeriesObjectCallback) {
        guard let url = URL(string: ApiProvider.comicsSeriesUrl(url: urlString)) else {
            return
        }
        
        MarvelObjectApiProvider.fetchDetails(url: url) { (result) in
            completionHandler(result)
        }
    }
}
