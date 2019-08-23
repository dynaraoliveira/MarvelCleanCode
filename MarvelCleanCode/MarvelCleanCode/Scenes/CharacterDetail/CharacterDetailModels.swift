//
//  CharacterDetailModels.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

enum CharacterDetail {
    enum FetchComics {
        struct Request {
            var character: Character?
        }
        
        struct Response {
            var character: Character?
            var comics: ComicsSeriesObject?
            var series: ComicsSeriesObject?
        }
        
        struct ViewModel {
            struct DisplayedComicsSeries {
                var name: String
                var image: String
            }
            var displayedComics: [DisplayedComicsSeries]
            var displayedSeries: [DisplayedComicsSeries]
        }
    }
}
