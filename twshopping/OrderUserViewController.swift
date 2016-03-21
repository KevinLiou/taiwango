//
//  OrderUserViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/21.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class OrderUserViewController: SPSingleColorViewController {

    var product:Product?
    
    @IBOutlet var productTitleLabel: SPWhiteTextLabel!
    @IBOutlet var productName: SPWhiteTextLabel!
    @IBOutlet var productPrice: SPWhiteTextLabel!
    
    @IBOutlet var OrderUserTitleLabel: SPWhiteTextLabel!
    @IBOutlet var nameTextField: SPTextField!
    @IBOutlet var emailTextField: SPTextField!
    @IBOutlet var addressTextField: SPTextField!
    @IBOutlet var mobileTextField: SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "購買商品"
        
        if let product_name = product?.name {
            self.productName.text = "商品名稱: \(product_name)"
            self.productPrice.text = "消費金額: 123,123"
        }
        
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        let buyItem = UIBarButtonItem(title: "購買", style: .Plain, target: self, action: "buyIt")
        self.navigationItem.rightBarButtonItem = buyItem
    }
    
    func buyIt(){
        let productInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductInfoViewController") as! ProductInfoViewController
        productInfoViewController.product = product
        productInfoViewController.infoType = .OrderInfo
        productInfoViewController.title = "購買完成"
        self.navigationController?.pushViewController(productInfoViewController, animated: true)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.productTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.OrderUserTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
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
