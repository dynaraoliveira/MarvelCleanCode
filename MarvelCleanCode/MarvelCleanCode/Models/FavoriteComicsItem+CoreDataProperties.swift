//
//  FavoriteComicsItem+CoreDataProperties.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteComicsItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteComicsItem> {
        return NSFetchRequest<FavoriteComicsItem>(entityName: "ComicsItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var resourceURI: String?
    @NSManaged public var comics: FavoriteComics?
}
