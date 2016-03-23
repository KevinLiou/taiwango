//
//  ForgotPwdViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class ForgotPwdViewController: SPSingleColorViewController {

    @IBOutlet var emailTextFIeld: SPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = NSLocalizedString("VCTitleResetPwd",comment: "")
        
        let submitItem = UIBarButtonItem(title: NSLocalizedString("ButtonTitleSure",comment: ""), style: .Plain, target: self, action: "submit")
        self.navigationItem.rightBarButtonItem = submitItem
    }
    
    // MARK: - Action
    func submit(){
        
        if !SPValidator.validatorWithEmail(self.emailTextFIeld.text!) {
            return
        }
        
        SPTools.showLoadingOnViewController(self)
        AVUser.requestPasswordResetForEmailInBackground(self.emailTextFIeld.text) { (succeeded: Bool, error: NSError!) -> Void in
            if succeeded {
                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleOK",comment: ""),
                    message: NSLocalizedString("AlertMessageResetPwdOK",comment: ""),
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                alertView.show()
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let errInfo = error.userInfo["error"] as! String
                
                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleFail",comment: ""),
                    message:errInfo ,
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                alertView.show()
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
