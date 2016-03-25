//
//  OrderCell.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/18.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet var dateLabel: SPWhiteTextLabel!
    @IBOutlet var nameLabel: SPWhiteTextLabel!
    @IBOutlet var snLabel: SPWhiteTextLabel!
    @IBOutlet var costLabel: SPWhiteTextLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.snLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.costLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)

        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderCell.fontSizeChanged(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.snLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.costLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}
