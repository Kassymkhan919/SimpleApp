//
//  SimpleAppTabBarController.swift
//  SimpleApp
//
//  Created by dev on 8/21/20.
//  Copyright © 2020 dev. All rights reserved.
//

import UIKit

class SimpleAppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = UIColor(named: "Black")
        tabBar.unselectedItemTintColor = UIColor(named: "Background Grey")
    }
    
}
