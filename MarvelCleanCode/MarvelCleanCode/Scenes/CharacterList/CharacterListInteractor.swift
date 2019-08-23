//
//  CharacterListInteractor.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterListBusinessLogic {
    func fetchMarvelObject(request: Characters.FetchCharacterList.Request)
    func createFavoriteCharacter(request: Characters.createFavoriteCharacter.Request)
}

class CharacterListInteractor: CharacterListBusinessLogic {
    var presenter: CharacterListPresentationLogic?
    
    private var characterWorker = CharacterWorker(characterListStore: MarvelObjectAPI(),
                                          characterListCoreDataStoreProtocol: MarvelObjectCoreDataStore())
    
    private var tabBarItemSelected: TabBarItemSelected?
    private var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
    
    fileprivate func fetchFavoriteCharacters(_ marvelObject: MarvelObject? = nil) {
        characterWorker.fetchFavoriteCharacters(completionHandler: { (favoriteCharacters, error) in
            let response = Characters.FetchCharacterList.Response(marvelObject: marvelObject,
                                                                  favoriteCharacters: favoriteCharacters,
                                                                  tabBarItemSelected: self.tabBarItemSelected,
                                                                  displayedCharacters: self.displayedCharacters)
            self.presenter?.presentMarvelObject(response: response)
        })
    }
    
    func fetchMarvelObject(request: Characters.FetchCharacterList.Request) {
        tabBarItemSelected = request.tabBarItemSelected
        displayedCharacters = request.displayedCharacters
        
        switch tabBarItemSelected {
        case .favorites?:
            fetchFavoriteCharacters()
        case .characters?:
            characterWorker.fetchCharacterList(offset: request.offset) { (result) in
                switch result {
                case .success(result: let marvelObject):
                    self.fetchFavoriteCharacters(marvelObject)
                    
                case .failure(error: let err):
                    self.presenter?.presentMessage(err.localizedDescription)
                }
            }
        case .none:
            presenter?.presentMessage("Unknown error")
        }
    }
    
    func createFavoriteCharacter(request: Characters.createFavoriteCharacter.Request) {
        characterWorker.createFavoriteCharacter(request.character) { (character, error) in
            if error == nil {
                let response = Characters.createFavoriteCharacter.Response(character: character,
                                                                           displayedCharacters: request.displayedCharacters)
                self.presenter?.presentFavoriteCharacter(response: response)
            } else {
                self.presenter?.presentMessage(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
}
