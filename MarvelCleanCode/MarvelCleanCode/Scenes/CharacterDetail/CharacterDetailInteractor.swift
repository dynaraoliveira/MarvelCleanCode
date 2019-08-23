//
//  CharacterDetailInteractor.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 22/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation

protocol CharacterDetailBusinessLogic {
    func createFavoriteCharacter(request: CharacterDetail.createFavoriteCharacter.Request)
    func fetchComics(request: CharacterDetail.FetchComics.Request)
    func fetchSeries(request: CharacterDetail.FetchSeries.Request)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    var presenter: CharacterDetailPresentationLogic?
    var characterDetailWorker = CharacterDetailWorker(characterDetailStore: MarvelObjectAPI(),
                                                      characterDetailCoreDataStoreProtocol: MarvelObjectCoreDataStore())
    
    func createFavoriteCharacter(request: CharacterDetail.createFavoriteCharacter.Request) {
        guard let character = request.character?.character else { return }
        characterDetailWorker.createFavoriteCharacter(character) { ( _, error) in
            if error == nil {
                guard let character = request.character else { return }
                self.presenter?.presentCharacterDetail(character: character)
            } else {
                self.presenter?.presentMessage(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    func fetchComics(request: CharacterDetail.FetchComics.Request) {
        var displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries] = []
        
        characterDetailWorker.fetchComicsSeriesObject(urlString: request.character?.uriComics ?? "") { (result) in
            switch result {
            case .success(result: let comics):
                for item in comics.data.results {
                    let image = "\(item.thumbnail.path ?? "").\(item.thumbnail.thumbnailExtension ?? "")"
                    let displayedComic = CharacterDetail.ViewModel.DisplayedComicsSeries(name: item.title,
                                                                                         image: image)
                    displayedComics.append(displayedComic)
                }
                self.presenter?.presentCharacterDetailComics(displayedComics: displayedComics)
            case .failure(error: let err):
                self.presenter?.presentMessage(err.localizedDescription)
            }
        }
    }
    
    func fetchSeries(request: CharacterDetail.FetchSeries.Request) {
        var displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries] = []
        
        characterDetailWorker.fetchComicsSeriesObject(urlString: request.character?.uriSeries ?? "") { (result) in
            switch result {
            case .success(result: let series):
                for item in series.data.results {
                    let image = "\(item.thumbnail.path ?? "").\(item.thumbnail.thumbnailExtension ?? "")"
                    let displayedComic = CharacterDetail.ViewModel.DisplayedComicsSeries(name: item.title,
                                                                                         image: image)
                    displayedSeries.append(displayedComic)
                }
                self.presenter?.presentCharacterDetailSeries(displayedSeries: displayedSeries)
            case .failure(error: let err):
                self.presenter?.presentMessage(err.localizedDescription)
            }
        }
    }
}
