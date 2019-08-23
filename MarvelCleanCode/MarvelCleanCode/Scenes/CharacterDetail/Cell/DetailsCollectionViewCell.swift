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
    
    var comic: ComicsItem? {
        didSet {
            detailsLabel?.text = comic?.name
            fetchData(urlString: comic?.resourceURI ?? "")
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
    
    func fetchData(urlString: String) {
//        let marvelObjectManager = MarvelObjectManager()
//        marvelObjectManager.fetchComicsSeriesObject(urlString: urlString) { (result) in
//            switch result() {
//            case .success(let comicsEventObject):
//                if let comicsSeriesThumbnail = comicsEventObject.data.results.first?.thumbnail {
//                    thumbnail = ThumbnailViewModel(thumbnail: comicsSeriesThumbnail)
//                }
//            case .failure:
//                detailsImageView?.image = UIImage()
//            }
//        }
    }
    
}
