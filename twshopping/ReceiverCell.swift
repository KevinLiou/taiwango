//
//  ReceiverCell.swift
//  twshopping
//
//  Created by Kevin on 2016/4/16.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ReceiverCell: UITableViewCell {

    @IBOutlet var titleLabel: SPWhiteTextLabel!
    @IBOutlet var nameLabel: SPWhiteTextLabel!
    @IBOutlet var addressLabel: SPWhiteTextLabel!
    @IBOutlet var mobileLabel: SPWhiteTextLabel!
    @IBOutlet var emailLabel: SPWhiteTextLabel!
    @IBOutlet var receiverTimeLabel: SPWhiteTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.addressLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.mobileLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.receiverTimeLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)

        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReceiverCell.fontSizeChanged(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.addressLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.mobileLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.receiverTimeLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }

}
