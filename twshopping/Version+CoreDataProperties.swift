//
//  Version+CoreDataProperties.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Version {

    @NSManaged var info: String?
    @NSManaged var policy: String?
    @NSManaged var team: String?
    @NSManaged var type: NSNumber?
    @NSManaged var version: String?
    @NSManaged var language: Language?

}
