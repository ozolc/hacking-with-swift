//
//  BuyCoordinator.swift
//  Coordinator02-advanced
//
//  Created by Maksim Nosov on 07/10/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class BuyCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
//    func didFinishBuying() {
//        parentCoordinator?.childDidFinish(self)
//    }
    
    
}
