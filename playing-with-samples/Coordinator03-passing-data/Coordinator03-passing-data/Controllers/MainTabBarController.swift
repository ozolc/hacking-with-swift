//
//  MainTabBarController.swift
//  Coordinator03-passing-data
//
//  Created by Maksim Nosov on 08/10/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        mainCoordinator.start()
        viewControllers = [mainCoordinator.navigationController]
    }
}
