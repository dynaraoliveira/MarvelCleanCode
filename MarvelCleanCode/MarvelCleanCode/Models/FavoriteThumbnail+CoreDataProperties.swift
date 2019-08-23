//
//  FavoriteThumbnail+CoreDataProperties.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteThumbnail {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteThumbnail> {
        return NSFetchRequest<FavoriteThumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var path: String?
    @NSManaged public var thumbnailExtension: String?
    @NSManaged public var character: FavoriteCharacter?
}
