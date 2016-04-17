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
    
    var product:Product?
    var api_product:[String:AnyObject]? //from api
    var order:[String:AnyObject]?
    
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
                    if let _SellPrice = _api_product["SellPrice"] {
                        cell.amountLabel.text = "\(NSLocalizedString("PriceOfOneProduct",comment: "")): \(_SellPrice)"
                    }
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
                    let quantity = (_order["quantity"] as? Double) ?? -1
                    let freight = (_order["freight"] as? Double) ?? -1
                    let amount = (_order["amount"] as? Double) ?? -1
                    let send_date = (_order["send_date"] as? String) ?? ""
                    
                    cell.external_order_no.text = "\(NSLocalizedString("",comment: "")): \(external_order_no)"
                    cell.deal_with_result.text = "\(NSLocalizedString("",comment: "")): \(deal_with_result)"
                    cell.style.text = "\(NSLocalizedString("",comment: "")): \(style_a) / \(style_b)"
                    cell.price.text = "\(NSLocalizedString("",comment: "")): \(price)"
                    cell.quantity.text = "\(NSLocalizedString("",comment: "")): \(quantity)"
                    cell.freight.text = "\(NSLocalizedString("",comment: "")): \(freight)"
                    cell.amount.text = "\(NSLocalizedString("",comment: "")): \(amount)"
                    cell.send_date.text = "\(NSLocalizedString("",comment: "")): \(send_date)"
                    
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
                    
                    
                    let _order_name = (_order["order_name"] as? String) ?? ""
                    let _order_address = (_order["order_address"] as? String) ?? ""
                    let _order_phone = (_order["order_phone"] as? String) ?? ""
                    let _order_email = (_order["order_email"] as? String) ?? ""
                    let _deliver_time = (_order["deliver_time"] as? String) ?? ""
                    
                    cell.nameLabel.text = "\(NSLocalizedString("StringName",comment: "")): \(_order_name)"
                    cell.addressLabel.text = "\(NSLocalizedString("StringAddress",comment: "")): \(_order_address)"
                    cell.mobileLabel.text = "\(NSLocalizedString("StringMobile",comment: "")): \(_order_phone)"
                    cell.emailLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(_order_email)"
                    cell.receiverTimeLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(_deliver_time)"
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
        let store = product?.store
        
        let infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InfoViewController") as! InfoViewController
        infoViewController.infoString = store?.info
        infoViewController.title = store?.name
        self.navigationController?.pushViewController(infoViewController, animated: true)
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
