//
//  Cate+CoreDataProperties.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/16.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Cate {

    @NSManaged var cate_id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var product: NSSet?
    @NSManaged var language: Language?

}
