//
//  ServiceURL.swift
//  twshopping
//
//  Created by Kevin on 2016/4/10.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import Foundation

enum SPServicePath:String {
    case API = "/api"
    case APP_INFO = "/api/app_info"
    case PUSH = "/api/push"
    case CATE = "/api/cate"
    case PRODUCT = "/api/product"
    case STORE = "/api/store"
    case ORDER_OK = "/api/order_ok"
    case ORDERS = "/api/orders"
}

enum SPServiceHost:String {
    case Host = "http://52.26.127.167/twshopping/index.php"
//    case Host = "http://twshopping.tno.tw"
    case APPURL = "https://itunes.apple.com/us/app/tai-wan-gou/id1095562394?l=zh&ls=1&mt=8"
}
