//
//  SPDataManager.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/16.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import CoreData

class SPDataManager {
    
    //Singleton
    static let sharedInstance = SPDataManager()
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    var context:NSManagedObjectContext {
        return appDelegate.managedObjectContext
    }
    
    func insertAllData(data data: AnyObject,lan:String){
        
        
        
        //languages
        let language = NSEntityDescription.insertNewObjectForEntityForName("Language", inManagedObjectContext: context) as! Language
        language.lan = lan
            
            //push
        let pushs = data["push"] as! [[String:AnyObject]]
        for dic_push in pushs {
            
            let push = NSEntityDescription.insertNewObjectForEntityForName("Push", inManagedObjectContext: context) as! Push
            push.push_id = dic_push["push_id"] as? Int
            push.type = dic_push["type"] as? Int
            push.title = dic_push["title"] as? String
            push.info = dic_push["info"] as? String
            push.product_id = dic_push["product_id"] as? Int
            push.language = language
        }
            
        
        //app_info
        let app_info = data["app_info"] as! [[String:AnyObject]]
        
        let version = NSEntityDescription.insertNewObjectForEntityForName("Version", inManagedObjectContext: context) as! Version
        let app_info_dic = app_info[0]
        let type = app_info_dic["type"] as! Int
        version.version = app_info_dic["version"] as? String
        version.type = NSNumber(integer: Int(type))
        version.info = app_info_dic["info"] as? String
        version.team = app_info_dic["team"] as? String
        version.policy = app_info_dic["policy"] as? String
        version.language = language
        
        //store
        let stores = data["store"] as! [[String:AnyObject]]
        for dic_store in stores {
            
            let store = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: context) as! Store
            
            store.store_id = dic_store["store_id"] as? Int
            store.name = dic_store["name"] as? String
            store.desc = dic_store["intro"] as? String
            store.mail = dic_store["mail"] as? String
            store.contact = dic_store["contact"] as? String
            store.mobile = dic_store["mobile"] as? String
            store.phone = dic_store["phone"] as? String
            store.info = dic_store["info"] as? String
            store.language = language
            
            
        }
        
        let cates = data["cate"] as! [[String:AnyObject]]
        for dic_cate in cates {
            
            //cate
            let cate = NSEntityDescription.insertNewObjectForEntityForName("Cate", inManagedObjectContext: context) as! Cate
            cate.language = language
            cate.name = dic_cate["name"] as? String
            cate.cate_id = dic_cate["cate_id"] as? Int
            
            
            //products
            let products = dic_cate["products"] as? [[String:AnyObject]]
            
            guard let p = products else{
                continue
            }
            
            for dic_product in p {
                
                let product = NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext: context) as! Product
                product.product_id = dic_product["product_id"] as? Int
                product.amount = dic_product["amount"] as? Int
                product.remain = dic_product["remain"] as? Int
                product.cate_id = dic_product["cate_id"] as? Int
                product.name = dic_product["name"] as? String
                product.image_urls = dic_product["image_urls"] as? String
                product.store_id = dic_product["store_id"] as? Int
                product.product_key = dic_product["product_key"] as? String
                product.desc = dic_product["intro"] as? String
                product.language = language
                product.cate = cate
                
                let product_store_id = dic_product["store_id"] as? Int
                if (product_store_id != nil) {
                    let store_predicate = NSPredicate(format: "store_id = \(product_store_id!)")
                    let stores = fetchStoreWithPredicate(predicate: store_predicate)
                    product.store = stores?.first
                }
            }
        }
        
        self.appDelegate.saveContext()
    }
    
    func insertProfile(email:String, mobilePhoneNumber:String?, address:String?, name:String?){
        let profile = NSEntityDescription.insertNewObjectForEntityForName("Profile", inManagedObjectContext: context) as! Profile
        profile.email = email
        profile.mobile = mobilePhoneNumber
        profile.address = address
        profile.name = name
        
        appDelegate.saveContext()
    }
    
    
    // MARK: - fetch
    func fetchProfile() -> Profile? {
        
        let request = NSFetchRequest(entityName: "Profile")
        
        do{
            let result = try context.executeFetchRequest(request) as! [Profile]
            return result.first
        }catch{
            return nil
        }
    }
    
    func fetchProductWithPredicate(predicate predicate:NSPredicate?) -> [Product]? {
        
        let request = NSFetchRequest(entityName: "Product")
        if predicate != nil {
            request.predicate = predicate
        }
        
        do{
            let result = try context.executeFetchRequest(request) as! [Product]
            return result
        }catch{
            return nil
        }
    }
    
    func fetchStoreWithPredicate(predicate predicate:NSPredicate?) -> [Store]? {
        
        let request = NSFetchRequest(entityName: "Store")
        if predicate != nil {
            request.predicate = predicate
        }
        
        do{
            let result = try context.executeFetchRequest(request) as! [Store]
            return result
        }catch{
            return nil
        }
    }
    
    func fetchCateWithPredicate(predicate predicate:NSPredicate?) -> [Cate]? {
        let request = NSFetchRequest(entityName: "Cate")
        if predicate != nil {
            request.predicate = predicate
        }
        
        let sortDesc = NSSortDescriptor(key: "cate_id", ascending: true)
        request.sortDescriptors = [sortDesc]
        
        do{
            let result = try context.executeFetchRequest(request) as! [Cate]
            return result
        }catch{
            return nil
        }
    }
    
    func fetchLanguageWithPredicate(predicate predicate:NSPredicate?) -> [Language]? {
        let request = NSFetchRequest(entityName: "Language")
        if predicate != nil {
            request.predicate = predicate
        }
        
        do{
            let result = try context.executeFetchRequest(request) as! [Language]
            return result
        }catch{
            return nil
        }
    }
    
    func fetchAppInfoWithPredicate(predicate predicate:NSPredicate?) -> Version? {
        let request = NSFetchRequest(entityName: "Version")
        if predicate != nil {
            request.predicate = predicate
        }
        
        do{
            let result = try context.executeFetchRequest(request) as! [Version]
            return result.first
        }catch{
            return nil
        }
    }
    
    // MARK: - update
    func updateProfileWith(info info:[String:String?], target:Profile) {
        
        target.name = info["name"]!
        target.mobile = info["mobile"]!
        target.address = info["address"]!
        target.email = info["email"]!
        
        appDelegate.saveContext()
    }
    
    // MARK: - delete
    func deleteProfile(){
        
        let profile = fetchProfile()
        
        if let del_profile = profile {
            context.deleteObject(del_profile)
            self.appDelegate.saveContext()
        }
    }
    
    
    // also delete all storage if its relationship of Language
    func deleteLanguageWithPredicate(predicate predicate:NSPredicate?){
        
        let languages = fetchLanguageWithPredicate(predicate: nil)
        for language in languages! {
            context.deleteObject(language)
        }
        self.appDelegate.saveContext()
    }
    
    
    
    
}