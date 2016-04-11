//
//  PushListViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class PushListViewController: SPSingleImageViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: [Push]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PushCell", forIndexPath: indexPath) as! PushCell
        cell.titleLabel.text = self.dataSource![indexPath.row].title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let push = self.dataSource![indexPath.row]
        
        guard let type = push.type else{
            return
        }
        
        switch Int(type) {
        case 1:
            //一般訊息
            let infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InfoViewController") as! InfoViewController
            infoViewController.infoString = push.info
            infoViewController.title = push.title
            self.navigationController?.pushViewController(infoViewController, animated: true)
            
        case 2:
            //商品推薦
            guard let product_id = push.product_id else{
                return
            }
            
            let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())' AND product_id = \(product_id)")
            let result = SPDataManager.sharedInstance.fetchProductWithPredicate(predicate: predicate)
            let product = result?.first
            
            guard let _product = product else{
                return
            }
            
            let productInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductInfoViewController") as! ProductInfoViewController
            productInfoViewController.product = _product
            productInfoViewController.infoType = .ProductInfo
            self.navigationController?.pushViewController(productInfoViewController, animated: true)
            
        default:break
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
