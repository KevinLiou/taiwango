//
//  LoginViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class LoginViewController: SPViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func tapGoToRegister(sender: UITapGestureRecognizer) {
        let registerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController")
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
    
    @IBAction func tapPassLogin(sender: UITapGestureRecognizer) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.entryMainViewController()
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
