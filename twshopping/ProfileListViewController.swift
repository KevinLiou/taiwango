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
        self.title = "個人/訂單資訊"
        
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
                cell.emailLabel.text = "聯絡信箱: \(email)"
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
                formatter.dateFormat = "yyyy-MM-dd a hh:mm:ss 您購買了,"
                let date_string = formatter.stringFromDate(date)
                
                cell.dateLabel.text = date_string
                cell.nameLabel.text = order["product"] as? String
                cell.costLabel.text = "交易金額: \(order["amount"] as! Int) NT"
                cell.snLabel.text = "訂單編號: \(order["order_id"] as! String)"
                
                return cell
            }
            
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let edtiProfile = UIAlertAction(title: "編輯個人資料", style: .Default, handler: { (_) -> Void in
                let profileEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileEditViewController") as! ProfileEditViewController
                profileEditViewController.profile = self.profile
                self.navigationController?.pushViewController(profileEditViewController, animated: true)
            })
            let changePwd = UIAlertAction(title: "變更密碼", style: .Default, handler: { (_) -> Void in
                
                let loginPages = UIStoryboard(name: "LoginPages", bundle: nil)
                let changePwdViewController = loginPages.instantiateViewControllerWithIdentifier("ForgotPwdViewController")
                self.navigationController?.pushViewController(changePwdViewController, animated: true)
            })
            let logOut = UIAlertAction(title: "登出", style: .Default, handler: { (_) -> Void in
                
                SPDataManager.sharedInstance.deleteProfile()
                AVUser.logOut()
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
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
            productInfoViewController.title = "購買記錄"
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
