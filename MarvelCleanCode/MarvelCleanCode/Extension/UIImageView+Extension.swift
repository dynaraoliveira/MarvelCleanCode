//
//  UIImageView+Extension.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(withURL: String) {
        Download.downloadImage(withURL: withURL, completion: { (image, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        })
    }
}
