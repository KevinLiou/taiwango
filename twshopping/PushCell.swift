//
//  PushCell.swift
//  twshopping
//
//  Created by Kevin on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class PushCell: UITableViewCell {

    @IBOutlet weak var titleLabel: SPWhiteTextLabel!
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
