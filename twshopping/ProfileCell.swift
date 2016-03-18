//
//  ProfileCell.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet var nameLabel: SPWhiteTextLabel!
    @IBOutlet var emailLabel: SPWhiteTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fontSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.emailLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }


}
