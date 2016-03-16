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
    
    func insertAllData(data data:[String:[String:[AnyObject]]]){
//        print(data)
        
        for (lan, value) in data {
            //languages
            let language = NSEntityDescription.insertNewObjectForEntityForName("Language", inManagedObjectContext: context) as! Language
            language.lan = lan
            
            //app_info
            let app_info = value["app_info"]

            let version = NSEntityDescription.insertNewObjectForEntityForName("Version", inManagedObjectContext: context) as! Version
            let app_info_dic = app_info![0]
            let type = app_info_dic["type"] as! Int
            version.version = app_info_dic["version"] as? String
            version.type = NSNumber(integer: Int(type))
            version.info = app_info_dic["info"] as? String
            version.team = app_info_dic["team"] as? String
            version.policy = app_info_dic["policy"] as? String
            
            //store
            let stores = value["store"] as! [[String:AnyObject]]
            for dic_store in stores {
                
                let store = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: context) as! Store
                
                store.store_id = dic_store["store_id"] as? Int
                store.name = dic_store["name"] as? String
                store.desc = dic_store["desc"] as? String
                store.mail = dic_store["mail"] as? String
                store.contact = dic_store["contact"] as? String
                store.mobile = dic_store["mobile"] as? String
                store.phone = dic_store["phone"] as? String
                store.info = dic_store["info"] as? String
                store.language = language
                
                
            }

  
            let cates = value["cate"] as! [[String:AnyObject]]
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
                    product.cate_id = dic_product["cate_id"] as? Int
                    product.name = dic_product["name"] as? String
                    product.image_urls = dic_product["image_urls"] as? String
                    product.store_id = dic_product["store_id"] as? Int
                    product.product_key = dic_product["product_key"] as? String
                    product.desc = dic_product["desc"] as? String
                    product.language = language
                    product.cate = cate
                    
                    let product_store_id = dic_product["store_id"] as? Int
                    if (product_store_id != nil) {
                        let store_predicate = NSPredicate(format: "store_id = \(product_store_id!)")
                        let stores = fetchStoreWithPredicate(predicate: store_predicate)
                        product.store = stores.first
                    }
                }
                
                
                
            }
            
        }
        
        self.appDelegate.saveContext()
    }
    
    func fetchStoreWithPredicate(predicate predicate:NSPredicate?) -> [Store] {
        
        let request = NSFetchRequest(entityName: "Store")
        if predicate != nil {
            request.predicate = predicate
        }
        
        do{
            let result = try context.executeFetchRequest(request) as! [Store]
            return result
        }catch{
            return []
        }
    }
    
    
}