//
//  OrderInfoViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/4/12.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import PINRemoteImage
import AVOSCloud
import pop

class OrderInfoViewController: SPSingleImageViewController, UITableViewDelegate {
    
//    var product:Product?
    var api_product:[String:AnyObject]? //from api
    var order:[String:AnyObject]?
    
    //status
    let payment_result_status = ["\(NSLocalizedString("payment_result_status0",comment: ""))",
                                 "\(NSLocalizedString("payment_result_status1",comment: ""))",
                                 "\(NSLocalizedString("payment_result_status2",comment: ""))",
                                 "\(NSLocalizedString("payment_result_status3",comment: ""))"]
    let deal_with_result_status = ["\(NSLocalizedString("deal_with_result_status0",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status1",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status2",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status3",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status4",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status5",comment: ""))",
                                   "\(NSLocalizedString("deal_with_result_status6",comment: ""))"]
    
    @IBOutlet weak var tableView: UITableView!
    
    //bottom views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var goTosStoreButton: SPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //訂單商品詳細資訊頁
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset.bottom = 8.0
    }
    
    override func pop() {
            let prevVC = self.navigationController?.viewControllers[((self.navigationController?.viewControllers.indexOf(self))! - 1)]
            if prevVC?.isKindOfClass(OrderUserViewController) == true {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else{
                super.pop()
            }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = api_product {
            return
        }
        
        if let _order = order {
            let product_sn = (_order["product_sn"] as? Int) ?? -1
            SPTools.showLoadingOnViewController(self)
            
            let lan = SPTools.getPreferredLanguages()
            let timestamp = UInt64(NSDate().timeIntervalSince1970)
            let md5string = SPTools.md5(string: "\(timestamp)kikirace")
            let parameters = ["Language":"\(Int(lan)!)", "ProductSN":"\(product_sn)", "Time": "\(timestamp)", "Key": md5string]
            
            SPService.sharedInstance.requestProductDetailWith(parameters) { (response) in
                
                SPTools.hideLoadingOnViewController(self)
                
                if let JSON = response.result.value {
                    print(JSON)
                    self.tableView.reloadData()
                    
                    let ErrorCode = JSON["ErrorCode"] as? Int
                    if let _ErrorCode = ErrorCode {
                        if _ErrorCode == 0 {
                            
                            let Products = JSON["Product"] as? [[String:AnyObject]]
                            self.api_product = Products?.first
                            
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductImageCell2", forIndexPath: indexPath)
                let imageView = cell.contentView.viewWithTag(1000) as! UIImageView
                
                if let _api_product = api_product {
                    if let image_url = _api_product["LargeIcon"] as? String {
                        imageView.pin_updateWithProgress = true
                        imageView.pin_setImageFromURL(NSURL(string: image_url))
                    }
                }
                
                return cell
            }
            else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell2", forIndexPath: indexPath) as! ProductInfoCell
                if let _api_product = api_product {
                    if let _ProductIntroduction = _api_product["ProductIntroduction"] as? String{
                        cell.descLabel.text = _ProductIntroduction
                    }
                    if let _ProductTitle = _api_product["ProductTitle"] as? String{
                        cell.titleLabel.text = _ProductTitle
                    }
                    cell.amountLabel.text = ""  //資訊不顯示商品價格
//                    if let _SellPrice = _api_product["SellPrice"] {
//                        cell.amountLabel.text = "\(NSLocalizedString("PriceOfOneProduct",comment: "")): \(_SellPrice)"
//                    }
                }
                return cell
            }else if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderInfoCell", forIndexPath: indexPath) as! OrderInfoCell
                
                if let _order = order {
                    
                    let external_order_no = (_order["external_order_no"] as? String) ?? ""
                    let deal_with_result = (_order["deal_with_result"] as? Int) ?? 0
                    let style_a = (_order["style_a"] as? String) ?? "--"
                    let style_b = (_order["style_b"] as? String) ?? "--"
                    let price = (_order["price"] as? Double) ?? -1
                    let quantity = (_order["quantity"] as? Int) ?? -1
                    let freight = (_order["freight"] as? Double) ?? -1
                    let amount = (_order["amount"] as? Double) ?? -1
                    let send_date = (_order["send_date"] as? String) ?? ""
                    let payment_result = (_order["payment_result"] as? Int) ?? 0
                    
                    cell.external_order_no.text = "\(NSLocalizedString("external_order_no",comment: "")): \(external_order_no)"
                    cell.deal_with_result.text = "\(NSLocalizedString("deal_with_result",comment: "")): \(deal_with_result_status[deal_with_result])"
                    cell.style.text = "\(NSLocalizedString("style",comment: "")): \(style_a) / \(style_b)"
                    cell.price.text = "\(NSLocalizedString("price",comment: "")): \(price)"
                    cell.quantity.text = "\(NSLocalizedString("quantity",comment: "")): \(quantity)"
                    cell.freight.text = "\(NSLocalizedString("freight",comment: "")): \(freight)"
                    cell.amount.text = "\(NSLocalizedString("amount",comment: "")): \(amount)"
                    cell.send_date.text = "\(NSLocalizedString("send_date",comment: "")): \(send_date)"
                    cell.payment_result.text = "\(NSLocalizedString("payment_result",comment: "")): \(payment_result_status[payment_result])"
                }
                
                return cell
            }else if indexPath.row == 3{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderUserCell", forIndexPath: indexPath) as! OrderUserCell
                if let _order = order {
                    
                    let _order_name = (_order["order_name"] as? String) ?? ""
                    let _order_address = (_order["order_address"] as? String) ?? ""
                    let _order_phone = (_order["order_phone"] as? String) ?? ""
                    let _order_email = (_order["order_email"] as? String) ?? ""
                    
                    cell.nameLabel.text = "\(NSLocalizedString("StringName",comment: "")): \(_order_name)"
                    cell.addressLabel.text = "\(NSLocalizedString("StringAddress",comment: "")): \(_order_address)"
                    cell.mobileLabel.text = "\(NSLocalizedString("StringMobile",comment: "")): \(_order_phone)"
                    cell.emailLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(_order_email)"
                }
                
                return cell
            }else{
                
                let cell = tableView.dequeueReusableCellWithIdentifier("ReceiverCell", forIndexPath: indexPath) as! ReceiverCell
                if let _order = order {
                    
                    
                    let _consignee_name = (_order["consignee_name"] as? String) ?? ""
                    let _consignee_address = (_order["consignee_address"] as? String) ?? ""
                    let _consignee_phone = (_order["consignee_phone"] as? String) ?? ""
                    let _consignee_email = (_order["consignee_email"] as? String) ?? ""
                    let _deliver_time = (_order["deliver_time"] as? String) ?? ""
                    
                    cell.nameLabel.text = "\(NSLocalizedString("StringName",comment: "")): \(_consignee_name)"
                    cell.addressLabel.text = "\(NSLocalizedString("StringAddress",comment: "")): \(_consignee_address)"
                    cell.mobileLabel.text = "\(NSLocalizedString("StringMobile",comment: "")): \(_consignee_phone)"
                    cell.emailLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(_consignee_email)"
                    cell.receiverTimeLabel.text = "\(NSLocalizedString("receiver_time",comment: "")): \(_deliver_time)"
                }
                return cell
            }
        }
            
        
        
        
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.bottomView.alpha == 0.0 {
            bottomViewShow()
        }else{
            bottomViewHidden()
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.fromValue = 0.3
        anim.toValue = 1.0
        cell.pop_addAnimation(anim, forKey: "fade")
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y < 0 {
            bottomViewShow()
        }else{
            bottomViewHidden()
        }
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func goToStoreInfo(sender: UIButton) {
        
        if let _order = order {
            let product_sn = (_order["product_sn"] as? Int) ?? -1
            
            let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())' AND product_sn = \(product_sn)")
            let products = SPDataManager.sharedInstance.fetchProductWithPredicate(predicate: predicate)
            let store = products?.first?.store
            
            let infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InfoViewController") as! InfoViewController
            infoViewController.infoString = store?.info
            infoViewController.title = store?.name
            self.navigationController?.pushViewController(infoViewController, animated: true)
            
        }
        
    }
    
    func bottomViewShow(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.bottomView.alpha = 1.0
        })
    }
    
    func bottomViewHidden(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.bottomView.alpha = 0.0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
