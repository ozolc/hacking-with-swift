//
//  Petition.swift
//  Project7
//
//  Created by Maksim Nosov on 22/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
