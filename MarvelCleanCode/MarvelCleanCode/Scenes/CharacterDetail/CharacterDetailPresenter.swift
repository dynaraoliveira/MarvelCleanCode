//
//  CharacterDetailPresenter.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(response: CharacterDetail.FetchComics.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    weak var viewController: CharacterListDisplayLogic?
    
    func presentCharacterDetail(response: CharacterDetail.FetchComics.Response) {
//        var displayedComics: [CharacterDetail.FetchComics.ViewModel.DisplayedComicsSeries] = []
//        var displayedSeries: [CharacterDetail.FetchComics.ViewModel.DisplayedComicsSeries] = []
//        
//        for comic in response.character?.data?.data ?? [] {
//            let displayedComics = CharacterDetail.FetchComics.ViewModel.DisplayedComicsSeries(name: , image: <#T##String#>)
//            displayedCharacters.append(displayedCharacter)
//        }
//        let viewModel = Characters.FetchCharacterList.ViewModel(displayedCharacters: displayedCharacters)
//        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
}
