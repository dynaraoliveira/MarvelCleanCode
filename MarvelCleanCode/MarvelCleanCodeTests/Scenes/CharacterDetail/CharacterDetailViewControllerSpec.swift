//
//  CharacterDetailViewControllerSpec.swift
//  MarvelCleanCodeTests
//
//  Created by Dynara Rico Oliveira on 23/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Quick
import Nimble

@testable import MarvelCleanCode

class CharacterDetailBusinessLogicMock: CharacterDetailBusinessLogic {
    var createFavoriteCharacterCalled = false
    var fetchComicsCalled = false
    var fetchSeriesCalled = false
    
    func createFavoriteCharacter(request: CharacterDetail.createFavoriteCharacter.Request) {
        createFavoriteCharacterCalled = true
    }
    
    func fetchComics(request: CharacterDetail.FetchComics.Request) {
        fetchComicsCalled = true
    }
    
    func fetchSeries(request: CharacterDetail.FetchSeries.Request) {
        fetchSeriesCalled = true
    }
}

class CharacterDetailViewControllerSpec: QuickSpec {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func spec() {
        describe("CharacterDetailViewController") {
            
            var sut: CharacterDetailViewController!
            let bundle = Bundle.main
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            
            beforeEach {
                sut = storyboard
                    .instantiateViewController(withIdentifier: CharacterDetailViewController.storyboardIdentifier) as? CharacterDetailViewController
                let _ = sut.view
            }
            
            it("should display character correctly") {
                sut.viewWillAppear(true)
                sut.character = MarvelObjectAPIMock().fetchCharacter().first
                expect(sut.title).to(equal("3-D Man"))
                expect(sut.descriptionLabel!.text).to(equal("description"))
            }
            
            it("should fetch comics and series right after the view appears") {
                let characterDetailBusinessLogicMock = CharacterDetailBusinessLogicMock()
                sut.interactor = characterDetailBusinessLogicMock
                sut.viewWillAppear(true)
                expect(characterDetailBusinessLogicMock.fetchComicsCalled).to(beTrue())
                expect(characterDetailBusinessLogicMock.fetchSeriesCalled).to(beTrue())
            }
            
            it("should mark character as favorite"){
                let characterDetailBusinessLogicMock = CharacterDetailBusinessLogicMock()
                sut.interactor = characterDetailBusinessLogicMock
                sut.character = MarvelObjectAPIMock().fetchCharacter().first
                sut.setFavorite()
                expect(characterDetailBusinessLogicMock.createFavoriteCharacterCalled).to(beTrue())
            }
            
            it("should show secound character"){
                sut.displayCharacterDetail(character: MarvelObjectAPIMock().fetchCharacter()[1])
                expect(sut.title).to(equal("A-Bomb (HAS)"))
                expect(sut.descriptionLabel!.text).to(equal("Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!"))
            }
            
            it("should be reload comics") {
                let collectionViewMock = CollectionViewMock(frame: CGRect.zero,
                                                            collectionViewLayout: UICollectionViewFlowLayout.init())
                sut.comicsCollectionView = collectionViewMock
                
                sut.displayCharacterDetailComics(displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")])
                
                expect(collectionViewMock.reloadDataCalled).to(beTrue())
            }
            
            it("should be reload series") {
                let collectionViewMock = CollectionViewMock(frame: CGRect.zero,
                                                            collectionViewLayout: UICollectionViewFlowLayout.init())
                sut.seriesCollectionView = collectionViewMock
                
                sut.displayCharacterDetailSeries(displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")])
                
                expect(collectionViewMock.reloadDataCalled).to(beTrue())
            }
            
            it("should fetch comics") {
                let collectionView = sut.comicsCollectionView
                
                sut.displayedComics = [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")]
                
                let numberOfItens = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
                
                expect(numberOfItens).to(equal(1))
            }
            
            it("should fetch series") {
                let collectionView = sut.seriesCollectionView
                
                sut.displayedSeries = [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")]
                
                let numberOfItens = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
                
                expect(numberOfItens).to(equal(1))
            }
            
            it("properly configured table view cell should display the comics") {
                let collectionView = sut.comicsCollectionView
                
                sut.displayedComics = [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")]
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! DetailsCollectionViewCell
                
                expect(cell.detailsLabel!.text).to(equal("name"))
            }
            
            it("properly configured table view cell should display the series") {
                let collectionView = sut.seriesCollectionView
                
                sut.displayedSeries = [CharacterDetail.ViewModel.DisplayedComicsSeries(name: "name", image: "")]
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! DetailsCollectionViewCell
                
                expect(cell.detailsLabel!.text).to(equal("name"))
            }
        }
    }
}
