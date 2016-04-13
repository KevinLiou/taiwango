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
        
            return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductImageCell2", forIndexPath: indexPath)
                let imageView = cell.contentView.viewWithTag(1000) as! UIImageView
                
//                if let image_url = product!.image_urls {
//                    imageView.pin_updateWithProgress = true
//                    imageView.pin_setImageFromURL(NSURL(string: image_url))
//                }
                
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderSnCell", forIndexPath: indexPath) as! OrderSnCell
                
                if let _order = order {
                    
//                    let date = _order.createdAt
//                    let formatter = NSDateFormatter()
//                    formatter.dateFormat = "\(NSLocalizedString("StringTradeTime",comment: "")): yyyy-MM-dd a hh:mm:ss"
//                    let date_string = formatter.stringFromDate(date)
                    
                    
                    cell.snLabel.text = "\(NSLocalizedString("StringOrderSn",comment: "")): \(_order["order_id"] as! String)"
                    cell.costLabel.text = "\(NSLocalizedString("StringOrderAmount",comment: "")): \(_order["amount"] as! Int) CNY"
//                    cell.dateLabel.text = date_string
                }
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell", forIndexPath: indexPath) as! ProductInfoCell
                cell.titleLabel.text = product?.name
                cell.descLabel.text = product?.desc
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderUserCell", forIndexPath: indexPath) as! OrderUserCell
                if let _order = order {
                    
                    cell.nameLabel.text = "\(NSLocalizedString("StringName",comment: "")): \(_order["name"] as! String)"
                    cell.addressLabel.text = "\(NSLocalizedString("StringAddress",comment: "")): \(_order["address"] as! String)"
                    cell.mobileLabel.text = "\(NSLocalizedString("StringMobile",comment: "")): \(_order["mobile"] as! String)"
                    cell.emailLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(_order["email"] as! String)"
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
