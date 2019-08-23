//
//  GlobalSplitViewController.swift
//  MarvelCleanCode
//
//  Created by Dynara Rico Oliveira on 30/06/19.
//  Copyright © 2019 Dynara Rico Oliveira. All rights reserved.
//

import UIKit

class GlobalSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        preferredDisplayMode = .allVisible
        
        guard let letfNavController = viewControllers.first as? UINavigationController,
            let characterListViewController = letfNavController.topViewController as? CharacterListViewController,
            let rightNavController = viewControllers.last as? UINavigationController,
            let characterDetailViewController = rightNavController.topViewController as? CharacterDetailViewController
            else { fatalError() }
        
        characterListViewController.characterSelectionDelegate = characterDetailViewController
        
        characterDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        characterDetailViewController.navigationItem.leftBarButtonItem = displayModeButtonItem
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
