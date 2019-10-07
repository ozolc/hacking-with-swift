//
//  Person.swift
//  Project10
//
//  Created by Maksim Nosov on 24/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
