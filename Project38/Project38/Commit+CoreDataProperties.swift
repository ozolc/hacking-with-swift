//
//  Commit+CoreDataProperties.swift
//  Project38
//
//  Created by Maksim Nosov on 29/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String

}
