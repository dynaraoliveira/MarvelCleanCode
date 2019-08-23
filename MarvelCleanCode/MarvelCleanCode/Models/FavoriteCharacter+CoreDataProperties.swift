//
//  FavoriteCharacter+CoreDataProperties.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteCharacter {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "Character")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var resultDescription: String?
    @NSManaged public var comics: FavoriteComics?
    @NSManaged public var series: FavoriteComics?
    @NSManaged public var thumbnail: FavoriteThumbnail?
}
