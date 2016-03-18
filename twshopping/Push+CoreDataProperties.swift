//
//  Push+CoreDataProperties.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Push {

    @NSManaged var push_id: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var title: String?
    @NSManaged var info: String?
    @NSManaged var product_id: NSNumber?
    @NSManaged var language: Language?

}
