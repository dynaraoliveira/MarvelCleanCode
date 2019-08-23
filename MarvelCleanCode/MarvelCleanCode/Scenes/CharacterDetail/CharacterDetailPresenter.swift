//
//  CharacterDetailPresenter.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter)
    func presentCharacterDetailComics(displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries])
    func presentCharacterDetailSeries(displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries])
    func presentMessage(_ message: String)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
    func presentCharacterDetail(character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter) {
        var displayedCharacterModified: Characters.FetchCharacterList.ViewModel.DisplayedCharacter
        displayedCharacterModified = character
        displayedCharacterModified.favorite = !displayedCharacterModified.favorite
        viewController?.displayCharacterDetail(character: displayedCharacterModified)
    }
    
    func presentCharacterDetailComics(displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries]) {
        viewController?.displayCharacterDetailComics(displayedComics: displayedComics)
    }
    
    func presentCharacterDetailSeries(displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries]) {
        viewController?.displayCharacterDetailSeries(displayedSeries: displayedSeries)
    }
    
    func presentMessage(_ message: String) {
        viewController?.displayMessage(message)
    }
    
}
