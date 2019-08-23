//
//  MarvelObjectApiProvider.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class MarvelObjectApiProvider {
    static func fetchMarvelObject(url: URL, completionHandler: @escaping MarvelObjectCallback) {
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                completionHandler(.failure(error: .cannotFetch("Error in response data")))
                return
            }
            
            do {
                let marvelObject = try JSONDecoder().decode(MarvelObject.self, from: data)
                completionHandler(.success(result: marvelObject))
            } catch {
                completionHandler(.failure(error: .cannotFetch("Error parse marvelObject")))
            }
        }
    }
    
    static func fetchDetails(url: URL, completionHandler: @escaping ComicsSeriesObjectCallback) {
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                completionHandler(.failure(error: .cannotFetch("Error in response data")))
                return
            }
            
            do {
                let comicsSeriesObject = try JSONDecoder().decode(ComicsSeriesObject.self, from: data)
                completionHandler(.success(result: comicsSeriesObject))
            } catch {
                completionHandler(.failure(error: .cannotFetch("Error parse comicsSeriesObject")))
            }
        }
    }
    
}
