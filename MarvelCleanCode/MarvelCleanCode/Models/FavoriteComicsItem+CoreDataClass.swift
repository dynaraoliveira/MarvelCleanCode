//
//  FavoriteComicsItem+CoreDataClass.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

public class FavoriteComicsItem: NSManagedObject {
    func toComicsItem() -> ComicsItem {
        return ComicsItem(resourceURI: "", name: name)
    }
    
    func fromComicsItem(_ comicsItem: ComicsItem, comics: FavoriteComics) {
        self.name = comicsItem.name
        self.comics = comics
    }
}
