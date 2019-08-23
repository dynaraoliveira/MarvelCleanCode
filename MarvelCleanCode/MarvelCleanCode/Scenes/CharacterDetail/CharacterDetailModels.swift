//
//  CharacterDetailModels.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

enum CharacterDetail {
    struct ViewModel {
        struct DisplayedComicsSeries {
            var name: String
            var image: String
        }
    }
    
    enum FetchComics {
        struct Request {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter?
        }
        
        struct Response {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter? 
            var comics: [ViewModel.DisplayedComicsSeries]
        }
    }
    
    enum FetchSeries {
        struct Request {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter?
        }
        
        struct Response {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter?
            var series: [ViewModel.DisplayedComicsSeries]
        }
    }
    
    enum createFavoriteCharacter {
        struct Request {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter?
        }
        
        struct Response {
            var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter?
        }
    }
}
