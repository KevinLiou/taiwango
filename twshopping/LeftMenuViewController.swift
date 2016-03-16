//
//  LeftMenuViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let sections:[String] = ["所有商品" ,"系統公告" ,"個人/訂單資訊" ,"應用程式聲明、政策" ,"開發團隊資訊"]
    var cates:[Cate]? = {

//        let predicate = NSPredicate(format: "language.lan like \(SPTools.getPreferredLanguages())")
                let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())'")
        let result = SPDataManager.sharedInstance.fetchCateWithPredicate(predicate: predicate)
        
        return result
    }()
    var showCate = false
    
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
                let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath)
                let titleLabel = cell.contentView.viewWithTag(1000) as! UILabel
                titleLabel.text = sections[indexPath.section]
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuDetailCell", forIndexPath: indexPath)
                let titleLabel = cell.contentView.viewWithTag(1000) as! UILabel
                
                let cate = cates![(indexPath.row-1)]
                titleLabel.text = cate.name
                return cell
            }
            
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath)
            let titleLabel = cell.contentView.viewWithTag(1000) as! UILabel
            titleLabel.text = sections[indexPath.section]
            return cell
        }

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
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
            
        }else{
            
            //        self.sideMenuViewController.setContentViewController(<#T##contentViewController: UIViewController!##UIViewController!#>, animated: true)
            self.sideMenuViewController.hideMenuViewController()
        }
        
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
