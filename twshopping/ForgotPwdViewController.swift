//
//  ForgotPwdViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ForgotPwdViewController: SPSingleColorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "忘記密碼"
        
        let submitItem = UIBarButtonItem(title: "送出", style: .Plain, target: self, action: "submit")
        self.navigationItem.rightBarButtonItem = submitItem
    }
    
    // MARK: - Action
    func submit(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
