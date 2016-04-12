//
//  Profile+CoreDataProperties.swift
//  twshopping
//
//  Created by Kevin on 2016/4/12.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Profile {

    @NSManaged var address: String?
    @NSManaged var email: String?
    @NSManaged var mobile: String?
    @NSManaged var name: String?
    @NSManaged var username: String?

}
