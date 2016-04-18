//
//  OrderInfoCell.swift
//  twshopping
//
//  Created by Kevin on 2016/4/16.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class OrderInfoCell: UITableViewCell {

    
    @IBOutlet var external_order_no:SPWhiteTextLabel!
    @IBOutlet var deal_with_result:SPWhiteTextLabel!
    @IBOutlet var style:SPWhiteTextLabel!
    @IBOutlet var price:SPWhiteTextLabel!
    @IBOutlet var quantity:SPWhiteTextLabel!
    @IBOutlet var freight:SPWhiteTextLabel!
    @IBOutlet var amount:SPWhiteTextLabel!
    @IBOutlet var send_date:SPWhiteTextLabel!
    @IBOutlet var payment_result:SPWhiteTextLabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.external_order_no.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.deal_with_result.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.style.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.price.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.quantity.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.freight.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.amount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.send_date.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.payment_result.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderInfoCell.fontSizeChanged(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.external_order_no.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.deal_with_result.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.style.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.price.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.quantity.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.freight.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.amount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.send_date.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.payment_result.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }


}
