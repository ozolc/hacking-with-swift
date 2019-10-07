//
//  MainCoordinator.swift
//  Coordinator01
//
//  Created by Maksim Nosov on 07/10/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
