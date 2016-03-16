//
//  Store+CoreDataProperties.swift
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

extension Store {

    @NSManaged var store_id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var mail: String?
    @NSManaged var contact: String?
    @NSManaged var mobile: String?
    @NSManaged var phone: String?
    @NSManaged var info: String?
    @NSManaged var product: NSSet?
    @NSManaged var language: NSManagedObject?

}
