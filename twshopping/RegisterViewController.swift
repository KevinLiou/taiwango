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
    
    @IBOutlet var policyButton: UIButton!
    
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
    
    
    @IBAction func policyShow(sender: AnyObject) {
        let predicate = NSPredicate(format: "lan = '\(SPTools.getPreferredLanguages())'")
        let language = SPDataManager.sharedInstance.fetchLanguageWithPredicate(predicate: predicate)
        let version = language?.first?.version
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let infoViewController = mainStoryboard.instantiateViewControllerWithIdentifier("InfoViewController") as! InfoViewController
        infoViewController.infoString = version?.policy
        infoViewController.title = "應用程式聲明、政策"
        
        let agreeItem = UIBarButtonItem(title: "我同意", style: .Plain, target: self, action: "agree")
        infoViewController.navigationItem.rightBarButtonItem = agreeItem
        
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
    
    func agree(){
        self.policyButton.selected = true
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    @IBAction func policyButtonClick(sender: AnyObject?) {
        self.policyButton.selected = !self.policyButton.selected
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
