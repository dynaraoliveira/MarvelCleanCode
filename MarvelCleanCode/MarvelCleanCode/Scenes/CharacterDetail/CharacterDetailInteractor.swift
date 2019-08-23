//
//  CharacterDetailInteractor.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterDetailBusinessLogic {
    func createFavoriteCharacter(request: Characters.createFavoriteCharacter.Request)
    func fetchComicsSeries(request: CharacterDetail.FetchComics.Request)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    var presenter: CharacterDetailPresentationLogic?
    var characterDetailWorker = CharacterDetailWorker(characterDetailStore: MarvelObjectAPI(),
                                                      characterDetailCoreDataStoreProtocol: MarvelObjectCoreDataStore())
    
    func createFavoriteCharacter(request: Characters.createFavoriteCharacter.Request) {
        characterDetailWorker.createFavoriteCharacter(request.character) { (character, error) in
//            if error == nil {
//                let response = Characters.createFavoriteCharacter.Response(character: character,
//                                                                           displayedCharacters: request.displayedCharacters)
//                presenter?.presentFavoriteCharacter(response: response)
//            } else {
//                presenter?.presentMessage(error?.localizedDescription ?? "Unknown error")
//            }
        }
    }
    
    func fetchComicsSeries(request: CharacterDetail.FetchComics.Request) {
        for item in request.character?.comics?.items ?? [] {
            characterDetailWorker.fetchComicsSeriesObject(urlString: item.resourceURI ?? "") { (result) in
                switch result {
                case .success(result: let comic):
                    print(comic.code)
                case .failure(error: let err):
                    print("erro")
//                    presenter?.presentMessage(err.localizedDescription)
                }
            }
        }
        
        for item in request.character?.series?.items ?? [] {
            characterDetailWorker.fetchComicsSeriesObject(urlString: item.resourceURI ?? "") { (result) in
                switch result {
                case .success(result: let comic):
                    print(comic.code)
                case .failure(error: let err):
                    print("erro")
                    //                    presenter?.presentMessage(err.localizedDescription)
                }
            }
        }
    }
}
