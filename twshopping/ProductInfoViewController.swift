//
//  ProductInfoViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/20.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProductInfoViewController: SPSingleImageViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("ProductInfoCell", forIndexPath: indexPath) as! ProductInfoCell
            cell.titleLabel.text = "標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題標題"
            cell.descLabel.text = "說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n說明說明說明說明，說明說明說明說明說明。說明說明說明說明說明說明\n"
            return cell
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
