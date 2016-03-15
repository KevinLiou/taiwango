//
//  ViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/7.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class ViewController: SPViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                
        


//        SPService.queryOrderById("") { (result, error) -> Void in
//            if result != nil {
//                print(result.className)
//                print(result.results)
//            }
//        }
        
        
        
        // log in
//        AVUser.logInWithUsernameInBackground("kevin.liou@infotimes.com.tw", password: "1234") { (user: AVUser!,error: NSError!) -> Void in
//            
//            if user != nil {
//                print(user.username);
//                print(user.email);
//            }else{
//                print(error)
//            }
//            
//        }
        
        
//        //        当前用户
//        
//        打开微博或者微信，它不会每次都要求用户都登陆，原因是因为在客户端做了用户数据的缓存。 因此，只要是调用了登录相关的接口，SDK 都会自动缓存登录用户的数据。 例如，判断当前用户是否为空，为空就跳转到登陆页面让用户登陆，如果不为空就跳转到首页：
//            +
//            
//        AVUser *currentUser = [AVUser currentUser];
//        if (currentUser != nil) {
//            // 跳转到首页
//        } else {
//            //缓存用户对象为空时，可打开用户注册界面…
//        }
//        +
//        如果不调用 登出 方法，当前用户的缓存将永久保存在客户端。
//            +
//            
//        登出
//        
//        用户登出系统，SDK 会自动的清理缓存信息。
//            +
//            
//            [AVUser logOut];  //清除缓存用户对象
//        AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        SPTools.showLoadingOnViewController(self)
        
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func menuItemClick(sender: UIBarButtonItem) {
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

