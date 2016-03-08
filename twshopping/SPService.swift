//
//  SPService.swift
//  twshopping
//
//  Created by Kevin on 2016/3/8.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import Foundation
import AVOSCloud

class SPService {
    
    class func saveOrderData(orderData: [String: String]){
        //存
        //        let testObject = AVObject(className: "TestObject")
        //        testObject.setObject("kevin", forKey: "name")
        //        testObject.save()
    }
    
    class func queryOrderById(userId: String, callBack: (result: AVCloudQueryResult!, error: NSError!) -> Void){
        //查詢
        //        AVQuery.doCloudQueryInBackgroundWithCQL("select * from TestObject where name='kevin1'") { (result: AVCloudQueryResult!, error: NSError!) -> Void in
        //            if result != nil {
        //                print(result.className)
        //                print(result.results)
        //            }
        //        }
        
        
        AVQuery.doCloudQueryInBackgroundWithCQL("select * from TestObject where name='kevin'") { (result: AVCloudQueryResult!, error: NSError!) -> Void in
            
            callBack(result: result, error: error);
            
//            if result != nil {
//                print(result.className)
//                print(result.results)
//            }
        }
    }
    
    class func singInWithUserInfo(){
        //sign in
        //        let user = AVUser()
        //        user.username = "KevinLiou2";
        //        user.email = "kevin.liou@infotimes.com.tw"
        //        user.password = "1234"
        //
        //        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
        //            if succeeded {
        //                print("成功,請至信箱收取驗證信。")
        //            }else{
        //                print(error)
        //            }
        //        }
    }
    
    
}