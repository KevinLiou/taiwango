//
//  ProfileEditViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/19.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class ProfileEditViewController: SPSingleColorViewController {
    
    var profile:Profile?

    @IBOutlet weak var nameTextField: SPTextField!
    @IBOutlet weak var emailTextField: SPTextField!
    @IBOutlet weak var addressTextField: SPTextField!
    @IBOutlet weak var mobileTextField: SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "詳細個人資料"
        
        let saveItem = UIBarButtonItem(title: "儲存", style: .Plain, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = saveItem
        
        /*
        註記一下
        
        AVUser              對應 Profile的關係
        =================================================
        email               =   email
        mobile              =   mobile(自行創建，非lean cloud預設手機欄位)
        address             =   address
        name                =   name
        username (登入帳號=初次註冊所填入的信箱 profile不記錄)
        */
        loadData()
    }
    
    func loadData(){
        
        
        SPTools.showLoadingOnViewController(self)
        
        AVUser.currentUser().refreshInBackgroundWithBlock { (user: AVObject!, error: NSError!) -> Void in
            if user != nil {
                
                let name = user["name"] as? String
                let address = user["address"]  as? String
                let mobile = user["mobile"] as? String
                let email = user["email"] as? String
                
                let info = ["name":name, "address":address, "mobile":mobile, "email":email]
                SPDataManager.sharedInstance.updateProfileWith(info: info, target: self.profile!)
                
                self.nameTextField.text = self.profile?.name
                self.emailTextField.text = self.profile?.email
                self.mobileTextField.text = self.profile?.mobile
                self.addressTextField.text = self.profile?.address
            }
            
            SPTools.hideLoadingOnViewController(self)
        }
    }
    
    func save(){
        
        if profile == nil{
            return
        }
        
        if !SPValidator.validatorWithEmail(self.emailTextField.text!) {
            return
        }
        
        if !SPValidator.validatorWithMobile(self.mobileTextField.text!) {
            return
        }
        
        if !SPValidator.validatorWithAddress(self.addressTextField.text!) {
            return
        }
        
        if !SPValidator.validatorWithName(self.nameTextField.text!) {
            return
        }
        
        SPTools.showLoadingOnViewController(self)
        
        let user = AVUser.currentUser()
        user.email = self.emailTextField.text
        user.setObject(self.mobileTextField.text, forKey: "mobile")
        user.setObject(addressTextField.text, forKey: "address")
        user.setObject(nameTextField.text, forKey: "name")
        user.saveInBackgroundWithBlock { (succeeded: Bool,error: NSError!) -> Void in
            
            if succeeded {
                
               let info = ["name":self.nameTextField.text, "address":self.addressTextField.text, "mobile":self.mobileTextField.text, "email":self.emailTextField.text]
                
                SPDataManager.sharedInstance.updateProfileWith(info: info, target: self.profile!)
                
                let alertView = UIAlertView(title: "儲存成功！", message:"" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
                alertView.show()
                
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let errInfo = error.userInfo["error"] as! String
                
                let alertView = UIAlertView(title: "儲存失敗！", message:errInfo , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
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
