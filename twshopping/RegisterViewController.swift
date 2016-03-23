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
    @IBOutlet var policyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "快速註冊"
        
//        let attributedString = NSMutableAttributedString(string: self.policyLabel.text!)
//        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(4, 9))
//        self.policyLabel.attributedText = attributedString
        
        let submitItem = UIBarButtonItem(title: NSLocalizedString("ItemTitleRegister",comment: ""), style: .Plain, target: self, action: "submit")
        self.navigationItem.rightBarButtonItem = submitItem
    }
    
    // MARK: - Action
    func submit(){
        
        
        if !SPValidator.validatorWithEmail(self.emailTextField.text!) {
            return
        }
        
        if !SPValidator.validatorWithTwoPassword(self.pwdTextField.text!, password2: self.pwdTextField2.text!){
            return
        }
        
        if !self.policyButton.selected{
            let alertView = UIAlertView(title: "", message: NSLocalizedString("AlertMessagePolicyAgree",comment: ""), delegate: nil, cancelButtonTitle: nil, otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        SPTools.showLoadingOnViewController(self)
        
        let user = SPUser()
        user.username = self.emailTextField.text
        user.password = self.pwdTextField.text
        user.email = self.emailTextField.text
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            
            if succeeded {
                
                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleRegisterOK",comment: ""),
                    message: NSLocalizedString("AlertMessageRegisterOK",comment: ""),
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
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
        infoViewController.title = NSLocalizedString("VCTitlePolicy",comment: "")
        
        let agreeItem = UIBarButtonItem(title: NSLocalizedString("ItemTitleAgree",comment: ""), style: .Plain, target: self, action: "agree")
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
