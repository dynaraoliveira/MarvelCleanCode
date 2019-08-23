//
//  CharacterDetailViewController.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 16/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

protocol CharacterDetailDisplayLogic: class {
    func displayCharacterDetail(character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter)
    func displayCharacterDetailComics(displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries])
    func displayCharacterDetailSeries(displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries])
    func displayMessage(_ message: String)
}

class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic, Identifiable {
    
    @IBOutlet weak var detailsImageView: UIImageView?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var comicsCollectionView: UICollectionView?
    @IBOutlet weak var seriesCollectionView: UICollectionView?
    
    var interactor: CharacterDetailBusinessLogic?
    
    var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter? {
        didSet {
            refreshUI()
        }
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsCollectionView?.delegate = self
        comicsCollectionView?.dataSource = self
        seriesCollectionView?.delegate = self
        seriesCollectionView?.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearMessage()
        fetchComics()
        fetchSeries()
        tabBarHidden(true)
    }
    
    private func fetchComics() {
        let request = CharacterDetail.FetchComics.Request(character: character)
        interactor?.fetchComics(request: request)
    }
    
    private func fetchSeries() {
        let request = CharacterDetail.FetchSeries.Request(character: character)
        interactor?.fetchSeries(request: request)
    }
    
    private func setup() {
        let viewController = self
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    var displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries] = []
    var displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries] = []
    
    func displayCharacterDetail(character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter) {
        self.character = character
    }
    
    func displayCharacterDetailComics(displayedComics: [CharacterDetail.ViewModel.DisplayedComicsSeries]) {
        self.displayedComics = displayedComics
        comicsCollectionView?.reloadData()
    }
    
    func displayCharacterDetailSeries(displayedSeries: [CharacterDetail.ViewModel.DisplayedComicsSeries]) {
        self.displayedSeries = displayedSeries
        seriesCollectionView?.reloadData()
    }
    
    func displayMessage(_ message: String) {
        alertMessage(message)
    }
    
    private func refreshUI() {
        loadViewIfNeeded()
        title = character?.name
        descriptionLabel?.text = character?.description ?? ""
        detailsImageView?.loadImage(withURL: character?.image ?? "")
        setNavigationItem()
    }
    
    private func setNavigationItem() {
        let favoriteButton = UIButton(type: .system)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        favoriteButton.tintColor = character?.favorite ?? false ? .white : .gray
        favoriteButton.addTarget(self, action: #selector(setFavorite), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc
    func setFavorite() {
        let request = CharacterDetail.createFavoriteCharacter.Request(character: character)
        interactor?.createFavoriteCharacter(request: request)
    }
    
}

extension CharacterDetailViewController: CharacterSelectionDelegate {
    func characterSelected(_ character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter) {
        self.character = character
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int = 0
        if collectionView == comicsCollectionView {
            count = displayedComics.count
        }
        if collectionView == seriesCollectionView {
            count = displayedSeries.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        if collectionView == comicsCollectionView {
            cell.comic = displayedComics[indexPath.row]
        }
        
        if collectionView == seriesCollectionView {
            cell.comic = displayedSeries[indexPath.row]
        }
        
        return cell
    }
}
