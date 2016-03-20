//
//  OrderSnCell.swift
//  twshopping
//
//  Created by Kevin on 2016/3/21.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class OrderSnCell: UITableViewCell {

    @IBOutlet weak var snLabel: SPWhiteTextLabel!
    @IBOutlet weak var costLabel: SPWhiteTextLabel!
    @IBOutlet weak var dateLabel: SPWhiteTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.snLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.costLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fontSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.snLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.costLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }


}
