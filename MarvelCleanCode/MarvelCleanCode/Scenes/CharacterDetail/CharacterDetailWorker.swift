//
//  CharacterDetailWorker.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterDetailStoreProtocol {
    func fetchComicsSeriesObject(urlString: String, completionHandler: @escaping ComicsSeriesObjectCallback)
}

protocol CharacterDetailCoreDataStoreProtocol {
    func createFavoriteCharacter(_ character: Character, completionHandler: @escaping (Character?, CharacterListStoreError?) -> Void)
}

typealias ComicsSeriesObjectCallback = (Result<ComicsSeriesObject>) -> Void

class CharacterDetailWorker {
    var characterDetailStore: CharacterDetailStoreProtocol
    var characterDetailCoreDataStoreProtocol: CharacterDetailCoreDataStoreProtocol
    
    init(characterDetailStore: CharacterDetailStoreProtocol,
         characterDetailCoreDataStoreProtocol: CharacterDetailCoreDataStoreProtocol) {
        self.characterDetailStore = characterDetailStore
        self.characterDetailCoreDataStoreProtocol = characterDetailCoreDataStoreProtocol
    }
    
    func fetchComicsSeriesObject(urlString: String, completionHandler: @escaping ComicsSeriesObjectCallback) {
        characterDetailStore.fetchComicsSeriesObject(urlString: urlString) { (result) in
            completionHandler(result)
        }
    }
    
    func createFavoriteCharacter(_ character: Character, completionHandler: @escaping (Character?, CharacterListStoreError?) -> Void) {
        characterDetailCoreDataStoreProtocol.createFavoriteCharacter(character) { (character, error) in
            completionHandler(character, error)
        }
    }
}
