//
//  MarvelCleanCodeUITests.swift
//  MarvelCleanCodeUITests
//
//  Created by Dynara Rico Oliveira on 23/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import XCTest

class MarvelCleanCodeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testScroll() {
        let characterCollectionView = app.collectionViews["CharacterCollectionView"]
        XCTAssertTrue(characterCollectionView.exists)
        characterCollectionView.swipeUp()
        characterCollectionView.swipeDown()
    }
    
    func testSelectedCharacter() {
        let characterCollectionView = app.collectionViews["CharacterCollectionView"]
        let cell = characterCollectionView.cells.firstMatch
        cell.tap()
    }
    
    func testSelectedFavoriteCharacter() {
        let characterCollectionView = app.collectionViews["CharacterCollectionView"]
        let cell = characterCollectionView.cells.firstMatch
        let buttonFavorite = cell.buttons.firstMatch
        buttonFavorite.tap()
    }

}
