//
//  ProfileListViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProfileListViewController: SPSingleImageViewController {

    @IBOutlet var tableView: UITableView!
    var profile:Profile?
    let orders:[[String:AnyObject]] = [["1":"1"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if profile == nil {
//            return 0
//        }
        
        return orders.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            
            cell.nameLabel.text = "Hello, Kevin~"
            cell.emailLabel.text = "聯絡信箱: gr20060513@gmail.com"
            
            return cell
        }else{
            
            if orders.count == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NoOrderCell", forIndexPath: indexPath)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
                cell.dateLabel.text = "2016-03-18 18:05 您購買了,"
                cell.nameLabel.text = "維力炸醬麵～～～"
                cell.snLabel.text = "訂單編號: ABC-123456789"
                cell.costLabel.text = "交易金額: 7,200 NT"
                
                return cell
            }
            
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let edtiProfile = UIAlertAction(title: "編輯個人資料", style: .Default, handler: { (_) -> Void in
                let profileEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileEditViewController")
                self.navigationController?.pushViewController(profileEditViewController!, animated: true)
            })
            let changePwd = UIAlertAction(title: "變更密碼", style: .Default, handler: { (_) -> Void in
                let changePwdViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChangePwdViewController")
                self.navigationController?.pushViewController(changePwdViewController!, animated: true)
            })
            
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alertController.addAction(edtiProfile)
            alertController.addAction(changePwd)
            alertController.addAction(cancel)
            
            self.presentViewController(alertController, animated: true, completion: nil)
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
