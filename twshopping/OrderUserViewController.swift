//
//  OrderUserViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/21.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud
import Alamofire

class OrderUserViewController: SPSingleColorViewController {

    var product:[String:AnyObject] = [:]
    var quantity = 1
    var total_price:Double = 0
    var profile:Profile?
    var cacheOrder:AVObject?
    var order_id = ""
    
    @IBOutlet var productTitleLabel: SPWhiteTextLabel!
    @IBOutlet var productName: SPWhiteTextLabel!
    @IBOutlet var productPriceOfOne: SPWhiteTextLabel!
    @IBOutlet var productQuantity: SPWhiteTextLabel!
    @IBOutlet var productPrice: SPWhiteTextLabel!
    @IBOutlet var stepper: UIStepper!
    
    
    @IBOutlet var OrderUserTitleLabel: SPWhiteTextLabel!
    @IBOutlet var nameTextField: SPTextField!
    @IBOutlet var emailTextField: SPTextField!
    @IBOutlet var addressTextField: SPTextField!
    @IBOutlet var mobileTextField: SPTextField!
    
    @IBOutlet var receiverUserTitleLabel: SPWhiteTextLabel!
    @IBOutlet var receiverNameTextField: SPTextField!
    @IBOutlet var receiverEmailTextField: SPTextField!
    @IBOutlet var receiverAddressTextField: SPTextField!
    @IBOutlet var receiverMobileTextField: SPTextField!
    @IBOutlet var receiverTimeTextField: SPTextField!
    
    @IBOutlet var sameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("VCTitleBuy",comment: "")
        
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.receiverUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        let buyItem = UIBarButtonItem(title: NSLocalizedString("StringBuy",comment: ""), style: .Plain, target: self, action: #selector(OrderUserViewController.buyIt))
        self.navigationItem.rightBarButtonItem = buyItem
        
        
        loadData()
    }
    
    
    func loadData(){
        
        if let _ProductQuantity = product["ProductQuantity"], let _SellPrice = product["SellPrice"],let _ = product["ProductSN"]{
            
            let Quantity = (_ProductQuantity as! NSString).doubleValue
            
            if let _ProductTitle = product["ProductTitle"]{
                self.productName.text = "\(NSLocalizedString("StringProductName",comment: "")): \(_ProductTitle)"
            }
            
            total_price = (_SellPrice as! NSString).doubleValue
            
            self.productPriceOfOne.text = "\(NSLocalizedString("PriceOfOneProduct",comment: "")): \(total_price)"
            self.stepper.maximumValue = Double(Quantity)
            self.stepper.minimumValue = 1
            self.productPrice.text = "\(NSLocalizedString("PriceOfAll",comment: "")): \(total_price)"
            
            self.nameTextField.text = profile?.name
            self.emailTextField.text = profile?.email
            self.mobileTextField.text = profile?.mobile
            self.addressTextField.text = profile?.address
        }else{
            
            self.navigationController?.popViewControllerAnimated(true)
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleBuyError",comment: ""),
                                        message:NSLocalizedString("AlertMessageNoRemain",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            
        }
        
        
        
    }
    
    func buyIt(){
        
        
        if profile == nil{
            return
        }
        
        //order user
        if !(SPValidator.validatorWithName(self.nameTextField.text!) && (self.nameTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageNameError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        if !(SPValidator.validatorWithAddress(self.addressTextField.text!) && (self.addressTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageAddressError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        if !(SPValidator.validatorWithMobile(self.mobileTextField.text!) && (self.mobileTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageMobileError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        
        
        //receiver user
        if !(SPValidator.validatorWithName(self.receiverNameTextField.text!) && (self.receiverNameTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageNameError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        if !(SPValidator.validatorWithAddress(self.receiverAddressTextField.text!) && (self.receiverAddressTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageAddressError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        if !(SPValidator.validatorWithMobile(self.receiverMobileTextField.text!) && (self.receiverMobileTextField.text?.characters.count > 0)) {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("AlertMessageMobileError",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            return
        }
        
        if !(SPValidator.validatorWithRceiverTime(self.receiverTimeTextField.text!)) {
            return
        }
        
        guard let _username = profile?.username else{
            return
        }
        self.view.endEditing(true)
        
//        order_id = "UDYSX-146051723576827"
//        self.mobileTextField.text = "15856774080"
//        self.receiverMobileTextField.text = "15856774080"
//        self.reqTradeInfo()
        
        
        
        
        
        order_id = SPTools.getRandomSnString()
        let payvc = UnionpaysdkService.CreateWebView(self, withOrderId: order_id, andAmount: total_price, andMemo: "\(_username),twshopping_ios", andPayCallBackUrl: "http://52.26.127.167/twshopping/index.php/api/callbackurl")
        self.presentViewController(payvc, animated: true, completion: nil)
        
        
        
        
        
        
//
        
        /*
        if let _product_name = self.product?.name,
            let _product_id = self.product?.product_id,
            let _amount = self.product?.amount,
            let _user_object_id = AVUser.currentUser().objectId,
            let _email = self.emailTextField.text,
            let _mobile = self.mobileTextField.text,
            let _address = self.addressTextField.text,
            let _name = self.nameTextField.text {
                
                
                let memo = "twshopping,\(order_id),\(_user_object_id).\(_product_id),\(_product_name),\(_amount),\(_email),\(_mobile),\(_address),\(_name)"
            
            do {
                
//                let payvc = UnionpaysdkService.CreateWebView(self, withOrderId: order_id, andAmount: Double(_amount), andMemo: memo, andPayCallBackUrl: "https://payment.skillfully.com.tw/back.aspx")
////http://twshopping.tno.tw/api/callbackurl
//                self.presentViewController(payvc, animated: true, completion: nil)
                
                
                
                
                let order = AVObject(className: "Orders")
                order.setObject(_user_object_id, forKey: "user_object_id")
                order.setObject(_email, forKey: "email")
                order.setObject(_mobile, forKey: "mobile")
                order.setObject(_address, forKey: "address")
                order.setObject(_name, forKey: "name")
                order.setObject("twshopping", forKey: "app")
                
                order.setObject(_product_id, forKey: "product_id")
                order.setObject(_product_name, forKey: "product")
                order.setObject(_amount, forKey: "amount")
                order.setObject(order_id, forKey: "order_id")
                order.setObject(memo, forKey: "memo")
                
                
                cacheOrder = order
            }
            
        }
         */
        
    }
    
    //call back
    func IPaymentIsSuccess(IsSuccess:Bool){
        if IsSuccess {
            print("IsSuccess")
            
            SPTools.showLoadingOnViewController(self)
            self.reqTradeInfo()
            
        }else{
            print("NoSuccess")
        }
    }
    
    func reqTradeInfo() {
        guard let _username = profile?.username else{
            return
        }
        
        let timestamp = "\(Int(NSDate().timeIntervalSince1970))"
        let md5string = SPTools.md5(string: "\(timestamp)twshopping")
        
        
        var orderEmail = ""
        if let OrderEmail = self.emailTextField.text{
            orderEmail = OrderEmail
        }
        
        var receiverEmail = ""
        if let ConsigneeEmail = self.receiverEmailTextField.text {
            receiverEmail = ConsigneeEmail
        }
        
        let parameters:[String:AnyObject]
            = [
                "order_id":order_id,
                "username": _username,
                "time": timestamp,
                "key": md5string,
                "app_name": "twshopping_ios",
                
                //以下為備份參數
                "ProductSN": self.product["ProductSN"]!,
                "StyleA": "",
                "StyleB": "",
                "Quantity": self.quantity,
                "Price": self.product["SellPrice"]!,
                
                "Amount": self.total_price,
                "OrderName": self.nameTextField.text!,
                "OrderAddress": self.addressTextField.text!,
                "OrderEmail": orderEmail,
                "OrderPhone": self.mobileTextField.text!,
                
                "ConsigneeName": self.receiverNameTextField.text!,
                "ConsigneeAddres": self.receiverAddressTextField.text!,
                "ConsigneeEmail": receiverEmail,
                "ConsigneePhone": self.receiverMobileTextField.text!,
                "DeliverTime": self.receiverTimeTextField.text!]
        
        
        
//        let parameters = ["order_id":order_id,
//                          "username": _username,
//                          "time": timestamp,
//                          "key": md5string,
//                          "app_name": "twshopping_ios"]
        
        
        SPService.sharedInstance.requestTradeInfoWith(parameters, completionHandler: { (response) in
            if let JSON = response.result.value {
                
                
                if let result = JSON["result"], let data = JSON["data"] as? [[String:AnyObject]]{
                    if 1 != result as! Int {
                        //延遲三秒後再重新傳送
                        let time: NSTimeInterval = 3.0
                        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                            self.reqTradeInfo()
                        }
                        
                    }else{
//                        print(JSON)
                        //成功後繼續
                        if let _data = data.first {
                            self.reqCreateOrder(_data)
                        }
                        
                    }
                }
            }else{
                let time: NSTimeInterval = 3.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                    self.reqTradeInfo()
                }
            }
            
        })
    }
    
    
    func reqCreateOrder(_data:[String:AnyObject]) {
        let currcode = _data["currcode"] as! String
        let resptime = _data["resptime"] as! String
        let rmbrate = (_data["rmbrate"] as! NSNumber).doubleValue
        let orderno = _data["orderno"] as! NSNumber
        
        
        var orderEmail = ""
        if let OrderEmail = self.emailTextField.text{
            orderEmail = OrderEmail
        }
        
        var receiverEmail = ""
        if let ConsigneeEmail = self.receiverEmailTextField.text {
            receiverEmail = ConsigneeEmail
        }
        
        
        let timestamp = UInt64(NSDate().timeIntervalSince1970)
        let md5string = SPTools.md5(string: "\(timestamp)kikirace")
        
        let parameters:[String:AnyObject]
            = [
                "Username": "G121902266",
                "Password": "happybirthday",
                "ExternalOrderNo": orderno,
                "ProductSN": self.product["ProductSN"]!,
                "StyleA": "",
                
                "StyleB": "",
                "Quantity": self.quantity,
                "Price": self.product["SellPrice"]!,
                "Amount": self.total_price,
                "OrderName": self.nameTextField.text!,
                
                "OrderAddress": self.addressTextField.text!,
                "OrderEmail": orderEmail,
                "OrderPhone": self.mobileTextField.text!,
                "ConsigneeName": self.receiverNameTextField.text!,
                "ConsigneeAddres": self.receiverAddressTextField.text!,
                
                "ConsigneeEmail": receiverEmail,
                "ConsigneePhone": self.receiverMobileTextField.text!,
                "DeliverTime": self.receiverTimeTextField.text!,
                "Result": 1,
                "PaymentResult": 1,
                
                "Param": "\(currcode),\(resptime),\(rmbrate)",
                "Time": "\(timestamp)",
                "Key": md5string
        ]
        
        print(parameters)
        SPService.sharedInstance.requestCreateOrderWith(parameters, completionHandler: { (response) in
            if let JSON = response.result.value {
                
                print(JSON)
                if let ErrorCode = JSON["ErrorCode"]{
                    
                    if let error_code = ErrorCode as? Int {
                        if error_code == 0 {
                            SPTools.hideLoadingOnViewController(self)
                            
                            //購買成功
                            let alertView = UIAlertView(title: NSLocalizedString("VCTitleBuySucceeded",comment: ""),
                                message: NSLocalizedString("BuyOkInfoMessage",comment: ""),
                                delegate: nil,
                                cancelButtonTitle: nil,
                                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                            alertView.show()
                            self.navigationController?.popViewControllerAnimated(true)
                            return
                        }
                    }
                    
                    let time: NSTimeInterval = 3.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                        self.reqCreateOrder(_data)
                    }
                    
                }else{
                    let time: NSTimeInterval = 3.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                        self.reqCreateOrder(_data)
                    }
                }
                
                
            }else{
                let time: NSTimeInterval = 3.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                    self.reqCreateOrder(_data)
                }
            }

        })
    }
    
    
//    func saveOrdersInfoWithObject(order:AVObject){
//        
//        order.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
//            
//            if succeeded {
//                
//                SPTools.hideLoadingOnViewController(self)
//                
//                let alertView = UIAlertView(title: NSLocalizedString("VCTitleBuySucceeded",comment: ""),
//                    message: "",
//                    delegate: nil,
//                    cancelButtonTitle: nil,
//                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
//                alertView.show()
//                
////                let productInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductInfoViewController") as! ProductInfoViewController
////                productInfoViewController.product = self.product
////                productInfoViewController.order = order
////                productInfoViewController.title = NSLocalizedString("VCTitleBuySucceeded",comment: "")
////                self.navigationController?.pushViewController(productInfoViewController, animated: true)
//            }else{
//                
//                //延遲三秒後再重新傳送
//                let time: NSTimeInterval = 3.0
//                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
//                dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
//                    self.saveOrdersInfoWithObject(order)
//                }
//                
//            }
//        }
//    }
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.receiverUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    // MARK : actions
    @IBAction func sameButtonClick(sender: UIButton) {
        sender.selected = !sender.selected
        
        if sender.selected {
            
            self.receiverNameTextField.text = self.nameTextField.text
            self.receiverEmailTextField.text = self.emailTextField.text
            self.receiverAddressTextField.text = self.addressTextField.text
            self.receiverMobileTextField.text = self.mobileTextField.text
            
        }else{
            
            self.receiverNameTextField.text = ""
            self.receiverEmailTextField.text = ""
            self.receiverAddressTextField.text = ""
            self.receiverMobileTextField.text = ""
        }
    }
    
    @IBAction func stepper(sender: UIStepper) {
        
        guard let _SellPrice = product["SellPrice"] else{
            return
        }
        
        let price = (_SellPrice as! NSString).doubleValue
        total_price = sender.value * price
        
        self.productQuantity.text = "\(NSLocalizedString("BuyQuantity",comment: "")): \(Int(sender.value))"
        self.productPrice.text = "\(NSLocalizedString("PriceOfAll",comment: "")): \(total_price)"
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
