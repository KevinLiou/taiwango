//
//  ProductInfoViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/20.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import PINRemoteImage

enum ProductInfoType {
    case ProductInfo, OrderInfo
}

class ProductInfoViewController: SPSingleImageViewController, UITableViewDelegate {

    var infoType:ProductInfoType = .ProductInfo //default
    var product:Product?
    
    @IBOutlet weak var tableView: UITableView!
    //bottom views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var goTosStoreButton: SPButton!
    @IBOutlet weak var buyThisButton: SPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //訂單商品詳細資訊頁
        //商品詳細資訊頁
        //共用此VC
        
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset.bottom = 8.0
        
        
        switch infoType {
        case .OrderInfo:
            self.buyThisButton.hidden = true
        case .ProductInfo:
            self.title = product?.name
            self.buyThisButton.hidden = false
        }
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch infoType {
        case .OrderInfo:
            return 4
        case .ProductInfo:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch infoType {
        case .OrderInfo:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductImageCell", forIndexPath: indexPath)
                let imageView = cell.contentView.viewWithTag(1000) as! UIImageView
                
                if let image_url = product!.image_urls {
                    imageView.pin_updateWithProgress = true
                    imageView.pin_setImageFromURL(NSURL(string: image_url))
                }
                
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderSnCell", forIndexPath: indexPath) as! OrderSnCell
                
                cell.snLabel.text = "訂單編號: ABC-1234567890"
                cell.costLabel.text = "交易金額: 7,200,345,678,900"
                cell.dateLabel.text = "交易時間: 2013-03-14 14:22:50"
                
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell", forIndexPath: indexPath) as! ProductInfoCell
                cell.titleLabel.text = product?.name
                cell.descLabel.text = product?.desc
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderUserCell", forIndexPath: indexPath) as! OrderUserCell
                cell.nameLabel.text = "姓名: testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
                cell.addressLabel.text = "地址: testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
                cell.mobileLabel.text = "電話: testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
                cell.emailLabel.text = "聯絡信箱: testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
                return cell
            }
            
        case .ProductInfo:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductImageCell", forIndexPath: indexPath)
                let imageView = cell.contentView.viewWithTag(1000) as! UIImageView
                
                if let image_url = product!.image_urls {
                    imageView.pin_updateWithProgress = true
                    imageView.pin_setImageFromURL(NSURL(string: image_url))
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell", forIndexPath: indexPath) as! ProductInfoCell
                cell.titleLabel.text = product?.name
                cell.descLabel.text = product?.desc
                return cell
            }
        }
        

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.bottomView.alpha == 0.0 {
            bottomViewShow()
        }else{
            bottomViewHidden()
        }
        
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
        
        if infoType == .OrderInfo {
            return
        }
        
        
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
