//
//  ProductListViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import PINRemoteImage

class ProductListViewController: SPSingleImageViewController {

    
    var dataSource:[Product]? = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let image = UIImage(named: "icon_profile")?.imageWithRenderingMode(.AlwaysOriginal)
        let rifhtButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: "goToPersonalPage")
        self.navigationItem.rightBarButtonItem = rifhtButtonItem;
    }

    // MARK: - Actions
    func goToPersonalPage(){
        
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = dataSource![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        
        
        if let image_url = product.image_urls {
            cell.productImageView.pin_updateWithProgress = true
            cell.productImageView.pin_setImageFromURL(NSURL(string: image_url))
        }
        cell.titleLabel.text = product.name
        cell.descLabel.text = product.desc
        
        return cell
        
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
