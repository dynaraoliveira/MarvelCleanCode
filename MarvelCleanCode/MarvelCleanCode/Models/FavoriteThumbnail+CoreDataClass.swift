//
//  FavoriteThumbnail+CoreDataClass.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

public class FavoriteThumbnail: NSManagedObject {
    func toThumbnail() -> Thumbnail {
        return Thumbnail(path: path, thumbnailExtension: thumbnailExtension)
    }
    
    func fromThumbnail(_ thumbnail: Thumbnail) {
        self.path = thumbnail.path
        self.thumbnailExtension = thumbnail.thumbnailExtension
    }
}
