//
//  FavoriteComics+CoreDataClass.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

public class FavoriteComics: NSManagedObject {
    func toComics(character: FavoriteCharacter) -> Comics {
        let items = self.items?.compactMap({ ($0 as? FavoriteComicsItem)?.toComicsItem() })
        return Comics(available: nil, returned: nil, collectionURI: nil, items: items)
    }
    
    func fromComics(type: ComicsType, character: FavoriteCharacter, items: [FavoriteComicsItem]) {
        switch type {
        case .comics:
            characterComics = character
        case .series:
            characterSeries = character
        }
        
        _ = items.compactMap({ addToItems($0) })
    }
    
}
