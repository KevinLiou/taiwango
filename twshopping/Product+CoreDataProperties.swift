//
//  Product+CoreDataProperties.swift
//  twshopping
//
//  Created by KevinLiou on 2016/4/12.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var amount: NSNumber?
    @NSManaged var cate_id: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var image_urls: String?
    @NSManaged var name: String?
    @NSManaged var product_id: NSNumber?
    @NSManaged var product_sn: NSNumber?
    @NSManaged var remain: NSNumber?
    @NSManaged var store_id: NSNumber?
    @NSManaged var cate: Cate?
    @NSManaged var language: Language?
    @NSManaged var store: Store?

}
