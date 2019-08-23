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
    
    func presentMarvelObject(response: Characters.FetchCharacterList.Response) {
        var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
        displayedCharacters.append(contentsOf: response.displayedCharacters)
        
        if response.tabBarItemSelected == .favorites {
            for character in response.favoriteCharacters ?? [] {
                let image = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.thumbnailExtension ?? "")"
                let displayedCharacter = Characters.FetchCharacterList.ViewModel.DisplayedCharacter(id: character.id,
                                                                                                    name: character.name,
                                                                                                    image: image,
                                                                                                    favorite: true,
                                                                                                    character: character,
                                                                                                    description: character.resultDescription)
                displayedCharacters.append(displayedCharacter)
            }
        } else {
            for character in response.marvelObject?.data?.data ?? [] {
                let image = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.thumbnailExtension ?? "")"
                let favoriteCharacter = response.favoriteCharacters?.filter({ $0.id == character.id }).first
                let favorite = favoriteCharacter == nil ? false : true
                let displayedCharacter = Characters.FetchCharacterList.ViewModel.DisplayedCharacter(id: character.id,
                                                                                                    name: character.name,
                                                                                                    image: image,
                                                                                                    favorite: favorite,
                                                                                                    character: character,
                                                                                                    description: character.resultDescription)
                displayedCharacters.append(displayedCharacter)
            }
        }
        let viewModel = Characters.FetchCharacterList.ViewModel(displayedCharacters: displayedCharacters)
        viewController?.displayFetchedOrders(viewModel: viewModel)
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
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
    
    func presentMessage(_ message: String) {
        viewController?.displayMessage(message)
    }
}
