//
//  ViewController.swift
//  Coordinator01
//
//  Created by Maksim Nosov on 07/10/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: (Buying & AccountCreating)?
    var buyAction: (() -> ())?
    var createAccountAction: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buyTapped(_ sender: Any) {
        buyAction?()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        createAccountAction?()
    }
    

}

