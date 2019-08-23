//
//  MarvelObjectCoreDataStore.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 11/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import CoreData

class MarvelObjectCoreDataStore: CharacterListCoreDataStoreProtocol & CharacterDetailCoreDataStoreProtocol {
    
    // MARK: - Managed object contexts
    var privateManagedObjectContext: NSManagedObjectContext
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarvelCleanCode")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Object lifecycle
    init() {
        privateManagedObjectContext = persistentContainer.viewContext
    }
    
    func fetchFavoriteCharacters(completionHandler: @escaping ([Character]?, CharacterListStoreError?) -> Void) {
        privateManagedObjectContext.perform {
            var markedFavorites: [Character] = []
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
                fetchRequest.returnsObjectsAsFaults = false
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [FavoriteCharacter]
                for favorite in results {
                    markedFavorites.append(favorite.toCharacter())
                }
                completionHandler(markedFavorites, nil)
            } catch {
                completionHandler(nil, .cannotFetch("Cannot fetch character"))
            }
        }
    }
    
    func createFavoriteCharacter(_ character: Character, completionHandler: @escaping (Character?, CharacterListStoreError?) -> Void) {
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
                fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: character.id))
                fetchRequest.returnsObjectsAsFaults = false
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [FavoriteCharacter]
                
                if let managedObject = results.first {
                    self.privateManagedObjectContext.delete(managedObject)
                    try self.privateManagedObjectContext.save()
                    completionHandler(character, nil)
                } else {
                    self.convertMarvelObjectToFavoriteMarvelObject(character)
                    try self.privateManagedObjectContext.save()
                    completionHandler(character, nil)
                }
            } catch {
                completionHandler(nil, .cannotFetch("Cannot create character with id \(String(describing: character.id))"))
            }
        }
    }
    
    fileprivate func convertMarvelObjectToFavoriteMarvelObject(_ character: Character) {
        let favoriteCharacter = NSEntityDescription
            .insertNewObject(forEntityName: "Character",
                             into: privateManagedObjectContext) as! FavoriteCharacter
        
        let serie = NSEntityDescription
            .insertNewObject(forEntityName: "Comics",
                             into: privateManagedObjectContext) as! FavoriteComics
        var serieItems: [FavoriteComicsItem] = []
        for item in character.series?.items ?? [] {
            let serieItem = NSEntityDescription
                .insertNewObject(forEntityName: "ComicsItem",
                                 into: privateManagedObjectContext) as! FavoriteComicsItem
            serieItem.fromComicsItem(item, comics: serie)
            serieItems.append(serieItem)
        }
        serie.fromComics(type: .series, character: favoriteCharacter, items: serieItems)
        
        let comic = NSEntityDescription
            .insertNewObject(forEntityName: "Comics",
                             into: privateManagedObjectContext) as! FavoriteComics
        var comicItems: [FavoriteComicsItem] = []
        for item in character.comics?.items ?? [] {
            let comicItem = NSEntityDescription
                .insertNewObject(forEntityName: "ComicsItem",
                                 into: privateManagedObjectContext) as! FavoriteComicsItem
            comicItem.fromComicsItem(item, comics: comic)
            comicItems.append(comicItem)
        }
        comic.fromComics(type: .comics, character: favoriteCharacter, items: comicItems)
        
        let favoriteThumbnail = NSEntityDescription
            .insertNewObject(forEntityName: "Thumbnail",
                             into: privateManagedObjectContext) as! FavoriteThumbnail
        if let thumbnail = character.thumbnail {
            favoriteThumbnail.fromThumbnail(thumbnail)
        }
        
        favoriteCharacter.fromCharacter(character, favoriteThumbnail: favoriteThumbnail, comics: comic, series: serie)
    }
    

}
