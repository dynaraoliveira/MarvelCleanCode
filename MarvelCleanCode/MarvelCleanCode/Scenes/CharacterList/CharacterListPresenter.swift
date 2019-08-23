//
//  CharacterListPresenter.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterListPresentationLogic {
    func presentMarvelObject(response: Characters.FetchCharacterList.Response)
    func presentFavoriteCharacter(response: Characters.createFavoriteCharacter.Response)
    func presentMessage(_ message: String)
}

class CharacterListPresenter: CharacterListPresentationLogic {
    weak var viewController: CharacterListDisplayLogic?
    
    fileprivate func getDisplayedCharacters(_ characters: [Character],
                                            _ response: Characters.FetchCharacterList.Response,
                                            _ displayedCharacters: inout [Characters.FetchCharacterList.ViewModel.DisplayedCharacter]) {
        for character in characters {
            let image = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.thumbnailExtension ?? "")"
            let uriComics = character.comics?.collectionURI ?? ""
            let uriSeries = character.series?.collectionURI ?? ""
            let favoriteCharacter = response.favoriteCharacters?.filter({ $0.id == character.id }).first
            let favorite = favoriteCharacter == nil ? false : true
            let displayedCharacter = Characters.FetchCharacterList.ViewModel.DisplayedCharacter(id: character.id,
                                                                                                name: character.name,
                                                                                                image: image,
                                                                                                favorite: favorite,
                                                                                                description: character.resultDescription,
                                                                                                uriComics: uriComics,
                                                                                                uriSeries: uriSeries,
                                                                                                character: character)
            displayedCharacters.append(displayedCharacter)
        }
    }
    
    func presentMarvelObject(response: Characters.FetchCharacterList.Response) {
        var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
        
        var characters: [Character] = []
        if response.tabBarItemSelected == .characters {
            for displayedCharacter in response.displayedCharacters {
                var displayedCharactersModified = displayedCharacter
                let favoriteCharacter = response.favoriteCharacters?.filter({ $0.id == displayedCharacter.id }).first
                displayedCharactersModified.favorite = favoriteCharacter == nil ? false : true
                displayedCharacters.append(displayedCharactersModified)
            }
            characters = response.marvelObject?.data?.data ?? []
        } else {
            characters = response.favoriteCharacters ?? []
        }
        
        getDisplayedCharacters(characters, response, &displayedCharacters)
        
        let viewModel = Characters.FetchCharacterList.ViewModel(displayedCharacters: displayedCharacters)
        viewController?.displayFetchedCharacters(viewModel: viewModel)
    }
    
    func presentFavoriteCharacter(response: Characters.createFavoriteCharacter.Response) {
        var displayedCharactersModified: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
        for var character in response.displayedCharacters {
            if character.id == response.character?.id {
                character.favorite = !character.favorite
            }
            displayedCharactersModified.append(character)
        }
        let viewModel = Characters.FetchCharacterList.ViewModel(displayedCharacters: displayedCharactersModified)
        viewController?.displayFetchedCharacters(viewModel: viewModel)
    }
    
    func presentMessage(_ message: String) {
        viewController?.displayMessage(message)
    }
}
