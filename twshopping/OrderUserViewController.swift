//
//  OrderUserViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/21.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class OrderUserViewController: SPSingleColorViewController {

    var product:Product?
    var profile:Profile?
    
    @IBOutlet var productTitleLabel: SPWhiteTextLabel!
    @IBOutlet var productName: SPWhiteTextLabel!
    @IBOutlet var productPrice: SPWhiteTextLabel!
    
    @IBOutlet var OrderUserTitleLabel: SPWhiteTextLabel!
    @IBOutlet var nameTextField: SPTextField!
    @IBOutlet var emailTextField: SPTextField!
    @IBOutlet var addressTextField: SPTextField!
    @IBOutlet var mobileTextField: SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "購買商品"
        
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        let buyItem = UIBarButtonItem(title: "購買", style: .Plain, target: self, action: "buyIt")
        self.navigationItem.rightBarButtonItem = buyItem
        
        
        loadData()
    }
    
    
    func loadData(){
        if let product_name = product?.name, let product_amount = product?.amount, let product_remain = product?.remain{
            self.productName.text = "商品名稱: \(product_name)"
            self.productPrice.text = "金額: \(product_amount) NT"
            
            if product_amount == 0 || product_remain == 0{
                self.navigationController?.popViewControllerAnimated(true)
                
                let alertView = UIAlertView(title: "無法購買！", message:"此商品已經售完囉。" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
                alertView.show()
            }
        }
        
        self.nameTextField.text = profile?.name
        self.emailTextField.text = profile?.email
        self.mobileTextField.text = profile?.mobile
        self.addressTextField.text = profile?.address
    }
    
    func buyIt(){
        
        
        if profile == nil{
            return
        }
        
        if !SPValidator.validatorWithEmail(self.emailTextField.text!) {
            return
        }
        
        if !(SPValidator.validatorWithMobile(self.mobileTextField.text!) && (self.mobileTextField.text?.characters.count > 0)) {
            return
        }
        
        if !(SPValidator.validatorWithAddress(self.addressTextField.text!) && (self.addressTextField.text?.characters.count > 0)) {
            return
        }
        
        if !(SPValidator.validatorWithName(self.nameTextField.text!) && (self.nameTextField.text?.characters.count > 0)) {
            return
        }
        
        self.view.endEditing(true)

        let order_id = SPTools.getRandomSnString()
        
        if let _product_name = self.product?.name,
            let _product_id = self.product?.product_id,
            let _amount = self.product?.amount,
            let _user_object_id = AVUser.currentUser().objectId,
            let _email = self.emailTextField.text,
            let _mobile = self.mobileTextField.text,
            let _address = self.addressTextField.text,
            let _name = self.nameTextField.text {
                
                
                let memo = "twshopping,\(order_id),\(_user_object_id).\(_product_id),\(_product_name),\(_amount),\(_email),\(_mobile),\(_address),\(_name)"
                
                let query = AVObject(className: "Orders")
                query.setObject(_user_object_id, forKey: "user_object_id")
                query.setObject(_email, forKey: "email")
                query.setObject(_mobile, forKey: "mobile")
                query.setObject(_address, forKey: "address")
                query.setObject(_name, forKey: "name")
                query.setObject("twshopping", forKey: "app")
                
                query.setObject(_product_id, forKey: "product_id")
                query.setObject(_product_name, forKey: "product")
                query.setObject(_amount, forKey: "amount")
                query.setObject(order_id, forKey: "order_id")
                query.setObject(memo, forKey: "memo")
                
                SPTools.showLoadingOnViewController(self)
                saveOrdersInfoWithObject(query)
        }
        
    }
    
    func saveOrdersInfoWithObject(query:AVObject){
        
        query.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
            
            if succeeded {
                
                SPTools.hideLoadingOnViewController(self)
                
                let productInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductInfoViewController") as! ProductInfoViewController
                productInfoViewController.product = self.product
                productInfoViewController.infoType = .OrderInfo
                productInfoViewController.order = query
                productInfoViewController.title = "購買完成"
                self.navigationController?.pushViewController(productInfoViewController, animated: true)
            }else{
                
                //延遲三秒後再重新傳送
                let time: NSTimeInterval = 3.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                    self.saveOrdersInfoWithObject(query)
                }
                
            }
        }
    }
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
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
