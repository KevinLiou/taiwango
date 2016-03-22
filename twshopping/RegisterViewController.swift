//
//  RegisterViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

@IBDesignable
class RegisterViewController: SPSingleColorViewController {

    @IBOutlet var emailTextField: SPTextField!
    @IBOutlet var pwdTextField: SPTextField!
    @IBOutlet var pwdTextField2: SPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "快速註冊"
        
        let submitItem = UIBarButtonItem(title: "送出", style: .Plain, target: self, action: "submit")
        self.navigationItem.rightBarButtonItem = submitItem
    }
    
    // MARK: - Action
    func submit(){
        
        SPTools.showLoadingOnViewController(self)
        
        let user = SPUser()
        user.username = self.emailTextField.text
        user.password = self.pwdTextField.text
        user.email = self.emailTextField.text
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            
            if succeeded {
                
                let alertView = UIAlertView(title: "註冊成功", message: "請使用註冊的帳號進行登入。", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
                alertView.show()
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                print(error)
            }
            
            SPTools.hideLoadingOnViewController(self)
        }
        
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
