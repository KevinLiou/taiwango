//
//  ProductInfoCell.swift
//  twshopping
//
//  Created by Kevin on 2016/3/20.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: SPWhiteTextLabel!
    @IBOutlet weak var descLabel: SPWhiteTextLabel!
    @IBOutlet var amountLabel: SPWhiteTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.descLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.amountLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProductInfoCell.fontSizeChanged(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK : observer
    func fontSizeChanged(notification:NSNotification) {
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.descLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.amountLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
