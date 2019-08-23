//
//  CharacterListViewControllerSpec.swift
//  MarvelCleanCodeTests
//
//  Created by Dynara Rico Oliveira on 23/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Quick
import Nimble

@testable import MarvelCleanCode

class MarvelObjectAPIMock {
    func fetchCharacter() -> [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] {
        var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
        let bundle = Bundle(for: type(of: self))
        let mock = LoaderMock(file: "MarvelObject", in: bundle)
        if let marvelObject = mock?.map(to: MarvelObject.self) {
            for character in marvelObject.data?.data ?? [] {
                let displayedCharacter = self.getDisplayedCharacter(character)
                displayedCharacters.append(displayedCharacter)
            }
        }
        return displayedCharacters
    }
    
    private func getDisplayedCharacter(_ character: Character) -> Characters.FetchCharacterList.ViewModel.DisplayedCharacter {
        let image = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.thumbnailExtension ?? "")"
        let uriComics = character.comics?.collectionURI ?? ""
        let uriSeries = character.series?.collectionURI ?? ""
        return Characters.FetchCharacterList.ViewModel.DisplayedCharacter(id: character.id,
                                                                          name: character.name,
                                                                          image: image,
                                                                          favorite: false,
                                                                          description: character.resultDescription,
                                                                          uriComics: uriComics,
                                                                          uriSeries: uriSeries,
                                                                          character: character)
    }
    
}

class CharacterListBusinessLogicMock: CharacterListBusinessLogic {
    var fetchMarvelObjectCalled = false
    var createFavoriteCharacterCalled = false
    
    func fetchMarvelObject(request: Characters.FetchCharacterList.Request) {
        self.fetchMarvelObjectCalled = true
    }
    
    func createFavoriteCharacter(request: Characters.createFavoriteCharacter.Request) {
        self.createFavoriteCharacterCalled = true
    }
}

class CharacterListRoutingLogicMock: CharacterListRoutingLogic {
    var routeToShowOrderCalled = false
    func routeToShowOrder(view: UISplitViewController?, detailsNavigationController: UINavigationController?) {
        routeToShowOrderCalled = true
    }
}

class CollectionViewMock: UICollectionView {
    var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }
}

class CharacterListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CharacterListViewController") {
            
            var sut: CharacterListViewController!
            let bundle = Bundle.main
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            
            beforeEach {
                sut = storyboard
                    .instantiateViewController(withIdentifier: CharacterListViewController.storyboardIdentifier) as? CharacterListViewController
                
                let _ = sut.view
            }
            
            it("should fetch characters right after the view appears") {
                let characterListBusinessLogicMock = CharacterListBusinessLogicMock()
                sut.interactor = characterListBusinessLogicMock
                sut.viewWillAppear(true)
                expect(characterListBusinessLogicMock.fetchMarvelObjectCalled).to(beTrue())
            }
            
            it("displaying fetched characters should reload the table view") {
                let collectionViewMock = CollectionViewMock(frame: CGRect.zero,
                                                            collectionViewLayout: UICollectionViewFlowLayout.init())
                sut.collectionView = collectionViewMock
                
                let displayedCharacters = MarvelObjectAPIMock().fetchCharacter()
                let viewModel = Characters.FetchCharacterList.ViewModel(displayedCharacters: displayedCharacters)
                sut.displayFetchedCharacters(viewModel: viewModel)
                
                expect(collectionViewMock.reloadDataCalled).to(beTrue())
            }
            
            it("should fetch 20 characters") {
                let collectionView = sut.collectionView
                
                sut.displayedCharacters = MarvelObjectAPIMock().fetchCharacter()
                
                let numberOfItens = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
                
                expect(numberOfItens).to(equal(20))
            }
            
            it("should be to display tab bar") {
                expect(sut.tabBarController?.tabBar.isHidden).to(beFalsy())
            }
            
            it("properly configured table view cell should display the character") {
                
                let collectionView = sut.collectionView
                
                sut.displayedCharacters = MarvelObjectAPIMock().fetchCharacter()
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! CharacterCollectionViewCell
                
                expect(cell.characterNameLabel!.text).to(equal("3-D Man"))
                expect(cell.favoriteButton!.tintColor).to(equal(UIColor.lightGray))
            }
            
            it("should go to the details screen right after selecting the cell") {
                let characterDetailViewController = storyboard
                    .instantiateViewController(withIdentifier: CharacterDetailViewController.storyboardIdentifier) as! CharacterDetailViewController
                
                let collectionView = sut.collectionView
                let characterListRoutingLogicMock = CharacterListRoutingLogicMock()
                sut.router = characterListRoutingLogicMock
                sut.displayedCharacters = MarvelObjectAPIMock().fetchCharacter()
                sut.characterSelectionDelegate = characterDetailViewController
                
                let indexPath = IndexPath(row: 0, section: 0)
                sut.collectionView(collectionView!, didSelectItemAt: indexPath)
                
                expect(characterListRoutingLogicMock.routeToShowOrderCalled).to(beTrue())
            }
            
            it("should load 20 more characters at the end of the scroll") {
                let collectionView = sut.collectionView
                
                sut.scrollViewDidEndDecelerating(collectionView!)
            
                expect(sut.offset).to(equal(20))
            }
            
            it("should record a character") {
                let characterListBusinessLogicMock = CharacterListBusinessLogicMock()
                sut.interactor = characterListBusinessLogicMock
                let displayedCharacter  = MarvelObjectAPIMock().fetchCharacter().first
                sut.createFavoriteCharacter(displayedCharacter!.character)
                
                expect(characterListBusinessLogicMock.createFavoriteCharacterCalled).to(beTrue())
            }
        }
    }
}
