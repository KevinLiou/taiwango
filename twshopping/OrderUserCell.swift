//
//  OrderUserCell.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/21.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class OrderUserCell: UITableViewCell {

    @IBOutlet var titleLabel: SPWhiteTextLabel!
    @IBOutlet var nameLabel: SPWhiteTextLabel!
    @IBOutlet var addressLabel: SPWhiteTextLabel!
    @IBOutlet var mobileLabel: SPWhiteTextLabel!
    @IBOutlet var emailLabel: SPWhiteTextLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.addressLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.mobileLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderUserCell.fontSizeChanged(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.addressLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.mobileLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}
