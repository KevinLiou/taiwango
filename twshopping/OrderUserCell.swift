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
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fontSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
}
