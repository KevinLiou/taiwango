//
//  ProfileListViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class ProfileListViewController: SPSingleImageViewController {

    @IBOutlet var tableView: UITableView!
    var profile:Profile?
    var orders:[AVObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("MenuTitlePersionalInfo",comment: "")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        
        loadData()
    }
    
    func loadData(){
        SPTools.showLoadingOnViewController(self)
        
        guard let user_object_id = AVUser.currentUser().objectId else{
            return
        }
        
        
        
        let query = AVQuery(className: "Orders")
        query.whereKey("user_object_id", equalTo: user_object_id)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (result: [AnyObject]!, error: NSError!) -> Void in
            
            if (error != nil){
                print(error)
                return
            }else{
                self.orders = result as! [AVObject]
                self.tableView.reloadData()
            }
            SPTools.hideLoadingOnViewController(self)
        }
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if orders.isEmpty{
            return 2
        }else{
            return orders.count + 1
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            
            if let name = profile?.name {
                cell.nameLabel.text = "Hello, \(name)"
            }else{
                cell.nameLabel.text = "Hello, "
            }
            
            if let email = profile?.email {
                cell.emailLabel.text = "\(NSLocalizedString("StringContactEmail",comment: "")): \(email)"
            }
            
            return cell
        }else{
            
            if orders.isEmpty {
                let cell = tableView.dequeueReusableCellWithIdentifier("NoOrderCell", forIndexPath: indexPath)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
                
                let order = orders[indexPath.row-1]
                
                let date = order.createdAt
                let formatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd a hh:mm:ss \(NSLocalizedString("StringYouBuy",comment: "")),"
                let date_string = formatter.stringFromDate(date)
                
                cell.dateLabel.text = date_string
                cell.nameLabel.text = order["product"] as? String
                cell.costLabel.text = "\(NSLocalizedString("StringOrderAmount",comment: "")): \(order["amount"] as! Int) CNY"
                cell.snLabel.text = "\(NSLocalizedString("StringOrderSn",comment: "")): \(order["order_id"] as! String)"
                
                return cell
            }
            
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let edtiProfile = UIAlertAction(title: NSLocalizedString("ButtonTitleEditProfile",comment: ""), style: .Default, handler: { (_) -> Void in
                let profileEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileEditViewController") as! ProfileEditViewController
                profileEditViewController.profile = self.profile
                self.navigationController?.pushViewController(profileEditViewController, animated: true)
            })
            let changePwd = UIAlertAction(title: NSLocalizedString("ButtonTitleChangePwd",comment: ""), style: .Default, handler: { (_) -> Void in
                
                let loginPages = UIStoryboard(name: "LoginPages", bundle: nil)
                let changePwdViewController = loginPages.instantiateViewControllerWithIdentifier("ForgotPwdViewController")
                self.navigationController?.pushViewController(changePwdViewController, animated: true)
            })
            let logOut = UIAlertAction(title: NSLocalizedString("ButtonTitleLogOut",comment: ""), style: .Default, handler: { (_) -> Void in
                
                SPDataManager.sharedInstance.deleteProfile()
                AVUser.logOut()
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            
            let cancel = UIAlertAction(title: NSLocalizedString("ButtonTitleCancel",comment: ""), style: .Cancel, handler: nil)
            alertController.addAction(edtiProfile)
            alertController.addAction(changePwd)
            alertController.addAction(logOut)
            alertController.addAction(cancel)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            let order = orders[indexPath.row-1]
            let product_id = order["product_id"] as? Int
            
            
            
            
            let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())' AND product_id = \(product_id!)")
            let result = SPDataManager.sharedInstance.fetchProductWithPredicate(predicate: predicate)
            let product = result?.first
            
            guard let _product = product else{
                return
            }
            
            let productInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductInfoViewController") as! ProductInfoViewController
            productInfoViewController.product = _product
            productInfoViewController.infoType = .OrderInfo
            productInfoViewController.order = order
            productInfoViewController.title = NSLocalizedString("VCTitleOrderHistory",comment: "")
            self.navigationController?.pushViewController(productInfoViewController, animated: true)
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
