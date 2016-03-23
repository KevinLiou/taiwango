//
//  LoginViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import RESideMenu
import AVOSCloud

@IBDesignable
class LoginViewController: SPSingleColorViewController {

    @IBOutlet var emailTextField: SPTextField!
    @IBOutlet var pwdTextField: SPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK : Actions
    @IBAction func tapToLogin(sender: SPButton) {
        
        if !SPValidator.validatorWithEmail(self.emailTextField.text!) {
            return
        }
        
        
        SPTools.showLoadingOnViewController(self)
        SPUser.logInWithUsernameInBackground(self.emailTextField.text, password: self.pwdTextField.text) { (user: AVUser!,error: NSError!) -> Void in
            
            if user != nil {
                
                let email = user.email
                let mobile = user["mobile"] as? String
                let address = user["address"] as? String
                let name = user["name"] as? String
                
                SPDataManager.sharedInstance.insertProfile(email, mobilePhoneNumber: mobile, address: address, name: name)
                
                self.tapPassLogin()
                
            }else{
                
                let errInfo = error.userInfo["error"] as! String
                
                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleLoginError",comment: ""),
                    message:errInfo ,
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                alertView.show()
            }
            SPTools.hideLoadingOnViewController(self)
            self.view.endEditing(true)
        }
    }
    
    @IBAction func tapGoToRegister(sender: UITapGestureRecognizer) {
        let registerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController")
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
    
    @IBAction func tapPassLogin() {
        
        if self.navigationController?.viewControllers.count > 1 {
            //返回上一頁
            self.navigationController?.popViewControllerAnimated(true)
        }else if (self.presentingViewController?.isKindOfClass(RESideMenu) == true) {
            //dismiss
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            //更換app root畫面
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.entryMainViewController()
        }
    }
    @IBAction func tapForgotPassword(sender: UITapGestureRecognizer) {
        let forgotPwdViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ForgotPwdViewController")
        self.navigationController?.pushViewController(forgotPwdViewController!, animated: true)
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
