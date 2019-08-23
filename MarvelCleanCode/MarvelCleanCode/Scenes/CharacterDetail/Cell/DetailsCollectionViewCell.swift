//
//  DetailsCollectionViewCell.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 06/07/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var shadowView: UIView?
    @IBOutlet weak var detailsImageView: UIImageView?
    @IBOutlet weak var detailsLabel: UILabel?
    
    var comic: CharacterDetail.ViewModel.DisplayedComicsSeries? {
        didSet {
            detailsLabel?.text = comic?.name
            detailsImageView?.loadImage(withURL: comic?.image ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView?.shadow()
        containerView?.round()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailsImageView?.image = UIImage()
        detailsLabel?.text = ""
    }
    
}
