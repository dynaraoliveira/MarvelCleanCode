//
//  CharacterListRouter.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 09/08/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

protocol CharacterListRoutingLogic: class {
    func routeToShowOrder(view: UISplitViewController?, detailsNavigationController: UINavigationController?)
}

class CharacterListRouter: CharacterListRoutingLogic {
    var viewController: UIViewController?
    
    func routeToShowOrder(view: UISplitViewController?, detailsNavigationController: UINavigationController?) {
        if let detailsNavigationController = detailsNavigationController {
            let orientation = UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
            
            if UIDevice.current.userInterfaceIdiom == .phone && orientation {
                viewController?.tabBarController?.tabBar.isHidden = true
            }
            
            view?.showDetailViewController(detailsNavigationController, sender: nil)
        }
    }
}
