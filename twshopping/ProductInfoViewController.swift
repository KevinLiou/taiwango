//
//  ProductInfoViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/20.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import PINRemoteImage
import AVOSCloud
import pop

enum ProductInfoType {
    case ProductInfo, OrderInfo
}

class ProductInfoViewController: SPSingleImageViewController, UITableViewDelegate {

    var product:Product? //from db
    var api_product:[String:AnyObject]? //from api
    var order:AVObject?
    
    @IBOutlet weak var tableView: UITableView!
    //bottom views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var goTosStoreButton: SPButton!
    @IBOutlet weak var buyThisButton: SPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //商品詳細資訊頁
        
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset.bottom = 8.0
        
        self.title = product?.name
        self.buyThisButton.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let _product_sn = product?.product_sn else{
            return
        }
        
        if let _ = api_product {
            return
        }
        
        SPTools.showLoadingOnViewController(self)
        
        let lan = SPTools.getPreferredLanguages()
        let timestamp = UInt64(NSDate().timeIntervalSince1970)
        let md5string = SPTools.md5(string: "\(timestamp)kikirace")
        let parameters = ["Language":Int(lan)!, "ProductSN":_product_sn, "Time": "\(timestamp)", "Key": md5string]
        
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
                    }
                }
            }
            
            
        }

        
    }
    
    
    
    override func pop() {
        super.pop()
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductImageCell", forIndexPath: indexPath)
                let imageView = cell.contentView.viewWithTag(1000) as! UIImageView
                
                if let _api_product = api_product {
                    if let image_url = _api_product["LargeIcon"] as? String {
                        imageView.pin_updateWithProgress = true
                        imageView.pin_setImageFromURL(NSURL(string: image_url))
                    }
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell", forIndexPath: indexPath) as! ProductInfoCell
                
                if let _api_product = api_product {
                    if let _ProductIntroduction = _api_product["ProductIntroduction"] as? String{
                        cell.descLabel.text = _ProductIntroduction
                    }
                    if let _ProductTitle = _api_product["ProductTitle"] as? String{
                        cell.titleLabel.text = _ProductTitle
                    }
                    if let _SellPrice = _api_product["SellPrice"] {
                        cell.amountLabel.text = "\(NSLocalizedString("PriceOfOneProduct",comment: "")): \(_SellPrice)TWD"
                    }
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
    
    @IBAction func buyThis(sender: UIButton) {
        
        
        let profile = SPDataManager.sharedInstance.fetchProfile()
        
        if let user_profile = profile {
            let orderUserViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderUserViewController") as! OrderUserViewController
            orderUserViewController.product = product
            orderUserViewController.profile = user_profile
            self.navigationController?.pushViewController(orderUserViewController, animated: true)
            
        }else{
            let loginPages = UIStoryboard(name: "LoginPages", bundle: nil)
            let loginViewController = loginPages.instantiateViewControllerWithIdentifier("LoginViewController")
            
            self.navigationController?.pushViewController(loginViewController, animated: true)
            return
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
