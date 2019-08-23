//
//  CharacterListModels.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

enum TabBarItemSelected: String {
    case characters = "characters"
    case favorites = "favorites"
}

enum Characters {
    
    enum FetchCharacterList {
        struct Request {
            var offset: Int?
            var tabBarItemSelected: TabBarItemSelected? = .characters
            var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter]
        }
        
        struct Response {
            var marvelObject: MarvelObject?
            var favoriteCharacters: [Character]?
            var tabBarItemSelected: TabBarItemSelected? = .characters
            var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter]
        }
        
        struct ViewModel {
            struct DisplayedCharacter {
                var id: Int
                var name: String
                var image: String
                var favorite: Bool
                var character: Character
                var description: String
            }
            var displayedCharacters: [DisplayedCharacter]
        }
    }
    
    enum createFavoriteCharacter {
        struct Request {
            var character: Character
            var displayedCharacters: [FetchCharacterList.ViewModel.DisplayedCharacter]
        }
        
        struct Response {
            var character: Character?
            var displayedCharacters: [FetchCharacterList.ViewModel.DisplayedCharacter]
        }
    }
    
}
