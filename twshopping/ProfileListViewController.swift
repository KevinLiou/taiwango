//
//  ProfileListViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud
import pop

class ProfileListViewController: SPSingleImageViewController {

    @IBOutlet var tableView: UITableView!
    var profile:Profile?
    var orders:[[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("MenuTitlePersionalInfo",comment: "")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }
    
    func loadData(){
        
        guard let _ = AVUser.currentUser().objectId, let username = profile?.username else{
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                                        message: NSLocalizedString("UnknownErrorMessage",comment: ""),
                                        delegate: nil,
                                        cancelButtonTitle: nil,
                                        otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        
        SPTools.showLoadingOnViewController(self)
        
        let timestamp = "\(Int(NSDate().timeIntervalSince1970))"
        let md5string = SPTools.md5(string: "\(timestamp)twshopping")
        let parameters = ["username": username,
                          "app_name": "twshopping",
                          "key": md5string,
                          "time": timestamp]
        
        SPService.sharedInstance.requestOrdersWith(parameters) { (response) in
            
            if let JSON = response.result.value{
                
                if let data = JSON["data"]{
                    
                    self.orders = data  as? [[String:AnyObject]]
//                    print(JSON)
                    self.tableView.reloadData()
                }
                
                
            }
            
            SPTools.hideLoadingOnViewController(self)
        }
        
        
        
        
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _orders = orders else{
            return 0
        }
        
        if _orders.isEmpty{
            return 2
        }else{
            return _orders.count + 1
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
            
            guard let _orders = orders else{
                let cell = tableView.dequeueReusableCellWithIdentifier("NoOrderCell", forIndexPath: indexPath)
                return cell
            }
            
            if _orders.isEmpty {
                let cell = tableView.dequeueReusableCellWithIdentifier("NoOrderCell", forIndexPath: indexPath)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
                
                let order = _orders[indexPath.row-1]
                
                cell.dateLabel.text = "\(NSLocalizedString("StringYouBuy",comment: ""))," //不顯示日期
                if let item_name = order["item_name"]{
                    cell.nameLabel.text = "\(item_name)"
                }
                
                if let amount = order["amount"]{
                    cell.costLabel.text = "\(NSLocalizedString("StringOrderAmount",comment: "")): \(amount)"
                }
                
                if let external_order_no = order["external_order_no"]{
                    cell.snLabel.text = "\(NSLocalizedString("StringOrderSn",comment: "")): \(external_order_no)"
                }
                
//                let date = order.createdAt
//                let formatter = NSDateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd a hh:mm:ss \(NSLocalizedString("StringYouBuy",comment: "")),"
//                let date_string = formatter.stringFromDate(date)
                
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
            
            guard let _orders = orders else{
                return
            }
            
            let order = _orders[indexPath.row-1]
            
            let orderInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderInfoViewController") as! OrderInfoViewController
            orderInfoViewController.order = order
            orderInfoViewController.title = NSLocalizedString("VCTitleOrderHistory",comment: "")
            self.navigationController?.pushViewController(orderInfoViewController, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.fromValue = 0.3
        anim.toValue = 1.0
        cell.pop_addAnimation(anim, forKey: "fade")
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
