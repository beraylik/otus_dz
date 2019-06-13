//
//  SplitViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 04/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    var collapseDetailViewController: Bool = true
    
    // ...
    
    // MARK: - UITableViewDelegate

}

class SplitViewDelegate: NSObject, UISplitViewControllerDelegate {
    // ...
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        guard
            let navigationController = primaryViewController as? UINavigationController,
            let controller = navigationController.topViewController as? SplitViewController
            else {
                return true
        }
        
        return controller.collapseDetailViewController
    }
}
