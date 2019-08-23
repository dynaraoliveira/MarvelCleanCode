//
//  CharacterDetailViewController.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 16/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController, Identifiable {
    
    @IBOutlet weak var detailsImageView: UIImageView?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var comicsCollectionView: UICollectionView?
    @IBOutlet weak var seriesCollectionView: UICollectionView?
    
    var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter? {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        comicsCollectionView?.delegate = self
        comicsCollectionView?.dataSource = self
        seriesCollectionView?.delegate = self
        seriesCollectionView?.dataSource = self
    }
    
    private func refreshUI() {
        loadViewIfNeeded()
        
        descriptionLabel?.text = ""
        detailsImageView?.image = UIImage()
        
        title = character?.name
        descriptionLabel?.text = character?.description
        detailsImageView?.loadImage(withURL: character?.image ?? "")
        
        comicsCollectionView?.reloadData()
        seriesCollectionView?.reloadData()
        setNavigationItem()
        stopLoading()
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
//        characterViewModel?.save {
//            setNavigationItem()
//        }
    }

}

extension CharacterDetailViewController: CharacterSelectionDelegate {
    func characterSelected(_ character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter) {
        self.character = character
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == comicsCollectionView {
//            return characterViewModel?.comics?.count ?? 0
//        }
//        if collectionView == seriesCollectionView {
//            return characterViewModel?.series?.count ?? 0
//        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
//        
//        if collectionView == comicsCollectionView {
//            cell.comic = characterViewModel?.comics?[indexPath.row]
//        }
//        
//        if collectionView == seriesCollectionView {
//            cell.comic = characterViewModel?.series?[indexPath.row]
//        }
        
        return cell
    }
    
}
