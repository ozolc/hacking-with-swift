//
//  Capital.swift
//  Project16
//
//  Created by Maksim Nosov on 26/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
