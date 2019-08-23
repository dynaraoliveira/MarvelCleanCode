//
//  FavoriteCharacter+CoreDataClass.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 07/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//
//

import Foundation
import CoreData

public class FavoriteCharacter: NSManagedObject {
    func toCharacter() -> Character {
        return Character(id: Int(id),
                         name: name ?? "",
                         resultDescription: resultDescription ?? "",
                         thumbnail: thumbnail?.toThumbnail(),
                         comics: comics?.toComics(character: self),
                         series: series?.toComics(character: self))
    }
    
    func fromCharacter(_ character: Character, favoriteThumbnail: FavoriteThumbnail, comics: FavoriteComics, series: FavoriteComics) {
        id = Int64(character.id)
        name = character.name
        resultDescription = character.resultDescription
        thumbnail = favoriteThumbnail
        self.comics = comics
        self.series = series
    }
}
