//
//  CharacterListViewController.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

protocol CharacterSelectionDelegate: class {
    func characterSelected(_ character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter)
}

protocol CharacterListDisplayLogic: class {
    func displayFetchedOrders(viewModel: Characters.FetchCharacterList.ViewModel)
    func displayMessage(_ message: String)
}

class CharacterListViewController: UICollectionViewController, CharacterListDisplayLogic, Identifiable {
    
    private var offset: Int?
    private var interactor: CharacterListBusinessLogic?
    private var router: CharacterListRoutingLogic?
    
    private var tabBarItemSelected: TabBarItemSelected {
        return TabBarItemSelected(rawValue: parent?.navigationController?.restorationIdentifier ?? "") ?? .characters
    }
    
    weak var characterSelectionDelegate: CharacterSelectionDelegate?
    
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
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearMessage()
        startLoading()
        fetchCharacters()
        tabBarHidden(false)
    }
    
    private func fetchCharacters() {
        let request = Characters.FetchCharacterList.Request(offset: offset,
                                                            tabBarItemSelected: tabBarItemSelected,
                                                            displayedCharacters: displayedCharacters)
        interactor?.fetchMarvelObject(request: request)
    }
    
    private func setup() {
        let viewController = self
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    var displayedCharacters: [Characters.FetchCharacterList.ViewModel.DisplayedCharacter] = []
    
    func displayFetchedOrders(viewModel: Characters.FetchCharacterList.ViewModel) {
        displayedCharacters = viewModel.displayedCharacters
        
        if let displayedCharacter = displayedCharacters.first {
            characterSelectionDelegate?.characterSelected(displayedCharacter)
        }
        
        collectionView.reloadData()
        stopLoading()
    }
    
    func displayMessage(_ message: String) {
        alertMessage(message)
        stopLoading()
    }
    
    // MARK: - Collection View data source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCharacters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = displayedCharacters[indexPath.row]
        let cell: CharacterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.character = character
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = displayedCharacters[indexPath.row]
        characterSelectionDelegate?.characterSelected(character)
        if let detailsViewController = characterSelectionDelegate as? CharacterDetailViewController,
            let detailsNavigationController = detailsViewController.navigationController {
            router?.routeToShowOrder(view: splitViewController, detailsNavigationController: detailsNavigationController)
        }
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height &&
            tabBarItemSelected == .characters {
            offset = (offset ?? 0) + ApiProvider.limit
            fetchCharacters()
        }
    }
}

extension CharacterListViewController: CharacterListViewCellDelegate {
    func createFavoriteCharacter(_ character: Character) {
        startLoading()
        let request = Characters.createFavoriteCharacter.Request(character: character,
                                                                 displayedCharacters: displayedCharacters)
        interactor?.createFavoriteCharacter(request: request)
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((view.frame.size.width) / 2) - 10
        return CGSize(width: width > 200 ? 200 : width, height: 225)
    }
}
