//
//  FavoriteComics+CoreDataProperties.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteComics {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteComics> {
        return NSFetchRequest<FavoriteComics>(entityName: "Comics")
    }

    @NSManaged public var collectionURI: String?
    @NSManaged public var characterComics: FavoriteCharacter?
    @NSManaged public var characterSeries: FavoriteCharacter?
    @NSManaged public var items: NSSet?
}

// MARK: Generated accessors for items
extension FavoriteComics {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: FavoriteComicsItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: FavoriteComicsItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
