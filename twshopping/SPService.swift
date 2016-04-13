//
//  SPService.swift
//  twshopping
//
//  Created by Kevin on 2016/3/8.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import Foundation
import Alamofire

class SPService {
    
    static let sharedInstance = SPService()
    
    func requestAllAPIMessageWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {

        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.API.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestPushWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.PUSH.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestAppInfoWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.APP_INFO.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestCateWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.CATE.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestProductWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.PRODUCT.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestTradeInfoWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.POST, "\(SPServiceHost.Host.rawValue)\(SPServicePath.TRADE_INFO.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    func requestProductDetailWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "http://kikistore.csmuse.com/kikistore/api/kikirace_getProductDetail.php", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
    
    func requestCreateOrderWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.GET, "http://kikistore.csmuse.com/kikistore/api/kikirace_createOrder.php", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
//    func requestOrderOKWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
//        
//        Alamofire.request(.GET, "\(SPServiceHost.Host.rawValue)\(SPServicePath.ORDER_OK.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
//        
//    }
    
    func requestOrdersWith(parameters: [String:AnyObject], completionHandler: Response<AnyObject, NSError> -> Void) {
        
        Alamofire.request(.POST, "\(SPServiceHost.Host.rawValue)\(SPServicePath.ORDERS.rawValue)", parameters: parameters).responseJSON(completionHandler: completionHandler);
        
    }
    
}