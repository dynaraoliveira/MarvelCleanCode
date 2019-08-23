//
//  CharacterCollectionViewCell.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

protocol CharacterListViewCellDelegate: class {
    func createFavoriteCharacter(_ character: Character)
}

class CharacterCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var characterNameLabel: UILabel?
    @IBOutlet weak var characterImageView: UIImageView?
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var shadowView: UIView?
    
    weak var delegate: CharacterListViewCellDelegate?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var character: Characters.FetchCharacterList.ViewModel.DisplayedCharacter? {
        didSet {
            characterNameLabel?.text = character?.name
            favoriteButton?.tintColor = character?.favorite ?? false ? .orange : .lightGray
            characterImageView?.loadImage(withURL: character?.image ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView?.round()
        self.shadowView?.shadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterNameLabel?.text = ""
        characterImageView?.image = UIImage()
    }
    
    @IBAction func favoriteButtonClick(_ sender: Any) {
        guard let character = character?.character else { return }
        delegate?.createFavoriteCharacter(character)
    }
}
