//
//  LeftMenuViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class LeftMenuViewController: SPSingleColorViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let sections:[String] = ["所有商品" ,"系統公告" ,"個人/訂單資訊" ,"應用程式聲明、政策" ,"開發團隊資訊"]
    var cates:[Cate]? = {

        let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())'")
        let result = SPDataManager.sharedInstance.fetchCateWithPredicate(predicate: predicate)
        
        return result
    }()
    var showCate = false
    var currentSelect:NSIndexPath = NSIndexPath(forRow: 1, inSection: 0) //default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 49.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return showCate ? ((cates?.count)! + 1) : 1
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath) as! LeftMenuCell
                cell.userSelected((currentSelect == indexPath))
                cell.titleLabel.text = sections[indexPath.section]
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuDetailCell", forIndexPath: indexPath) as! LeftMenuDetailCell
                cell.userSelected((currentSelect == indexPath))
                let titleLabel = cell.contentView.viewWithTag(1000) as! UILabel
                let cate = cates![(indexPath.row-1)]
                titleLabel.text = cate.name
                return cell
            }
            
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath) as! LeftMenuCell
            cell.userSelected((currentSelect == indexPath))
            cell.titleLabel.text = sections[indexPath.section]
            return cell
        }

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                showCate = !showCate
                
                var indexPaths:[NSIndexPath] = []
                for (index, _) in cates!.enumerate() {
                    indexPaths.append(NSIndexPath(forRow: index+1, inSection: 0))
                }
                
                if showCate {
                    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Bottom)
                }else{
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                }
                
                return;
            }else{
                
                if currentSelect == indexPath {
                    self.sideMenuViewController.hideMenuViewController()
                    return;
                }
                
                //products
                let cate = cates![indexPath.row-1]
                let products = cate.product?.allObjects as! [Product]
                let navProductListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavProductListViewController") as! SPNavigationController
                
                let productListViewController = navProductListViewController.viewControllers.first as! ProductListViewController
                
                productListViewController.dataSource = products
                productListViewController.title = cate.name
                self.sideMenuViewController.setContentViewController(navProductListViewController, animated: true)
                self.sideMenuViewController.hideMenuViewController()

            }
            
            
        }else if indexPath.section == 1{
            //push list
            let predicate = NSPredicate(format: "lan = '\(SPTools.getPreferredLanguages())'")
            let language = SPDataManager.sharedInstance.fetchLanguageWithPredicate(predicate: predicate)
            let pushs = language?.first?.push?.allObjects as! [Push]
            
            let navPushListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavPushListViewController") as! SPNavigationController
            let pushListViewController = navPushListViewController.viewControllers.first as! PushListViewController
            pushListViewController.title = sections[indexPath.section]
            pushListViewController.dataSource = pushs
            self.sideMenuViewController.setContentViewController(navPushListViewController, animated: true)
            self.sideMenuViewController.hideMenuViewController()
            
        }else if indexPath.section == 2{
            
            let profile = SPDataManager.sharedInstance.fetchProfile()
            
            if let user_profile = profile {
                
                
                
            }else{
                let loginPages = UIStoryboard(name: "LoginPages", bundle: nil)
                let loginViewController = loginPages.instantiateViewControllerWithIdentifier("NavLoginViewController")
                
                self.presentViewController(loginViewController, animated: true, completion: nil)
                return
            }
            
            
            
        }else if indexPath.section == 3{
            
            let predicate = NSPredicate(format: "lan = '\(SPTools.getPreferredLanguages())'")
            let language = SPDataManager.sharedInstance.fetchLanguageWithPredicate(predicate: predicate)
            let version = language?.first?.version
            
            let navInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavInfoViewController") as! SPNavigationController
            let infoViewController = navInfoViewController.viewControllers.first as! InfoViewController
            infoViewController.infoString = version?.policy
            infoViewController.title = sections[indexPath.section]
            self.sideMenuViewController.setContentViewController(navInfoViewController, animated: true)
            self.sideMenuViewController.hideMenuViewController()
            
        }else if indexPath.section == 4{
            
            let predicate = NSPredicate(format: "lan = '\(SPTools.getPreferredLanguages())'")
            let language = SPDataManager.sharedInstance.fetchLanguageWithPredicate(predicate: predicate)
            let version = language?.first?.version
            
            let navInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavInfoViewController") as! SPNavigationController
            let infoViewController = navInfoViewController.viewControllers.first as! InfoViewController
            infoViewController.infoString = version?.team
            infoViewController.title = sections[indexPath.section]
            self.sideMenuViewController.setContentViewController(navInfoViewController, animated: true)
            self.sideMenuViewController.hideMenuViewController()
            
        }
        
        currentSelect = indexPath
        tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
