//
//  CharacterListWorker.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol MarvelObjectListStoreProtocol {
    func fetchCharacter(offset: Int?, completionHandler: @escaping MarvelObjectCallback)
}

protocol CharacterListCoreDataStoreProtocol {
    func fetchFavoriteCharacters(completionHandler: @escaping ([Character]?, CharacterListStoreError?) -> Void)
    func createFavoriteCharacter(_ character: Character, completionHandler: @escaping (Character?, CharacterListStoreError?) -> Void)
}

typealias MarvelObjectCallback = (Result<MarvelObject>) -> Void

enum Result<T> {
    case success(result: T)
    case failure(error: CharacterListStoreError)
}

enum CharacterListStoreError: Equatable, Error {
    case cannotFetch(String)
}

class CharacterWorker {
    var characterListStore: MarvelObjectListStoreProtocol
    var characterListCoreDataStoreProtocol: CharacterListCoreDataStoreProtocol
    
    init(characterListStore: MarvelObjectListStoreProtocol,
         characterListCoreDataStoreProtocol: CharacterListCoreDataStoreProtocol) {
        self.characterListStore = characterListStore
        self.characterListCoreDataStoreProtocol = characterListCoreDataStoreProtocol
    }
    
    func fetchCharacterList(offset: Int?, completionHandler: @escaping MarvelObjectCallback) {
        characterListStore.fetchCharacter(offset: offset) { (result) in
            completionHandler(result)
        }
    }
    
    func fetchFavoriteCharacters(completionHandler: @escaping ([Character]?, CharacterListStoreError?) -> Void) {
        characterListCoreDataStoreProtocol.fetchFavoriteCharacters() { (character, error) in
            completionHandler(character, error)
        }
    }
    
    func createFavoriteCharacter(_ character: Character, completionHandler: @escaping (Character?, CharacterListStoreError?) -> Void) {
        characterListCoreDataStoreProtocol.createFavoriteCharacter(character) { (character, error) in
            completionHandler(character, error)
        }
    }
}
