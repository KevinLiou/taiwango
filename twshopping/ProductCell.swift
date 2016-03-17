//
//  ProductCell.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: SPImageView!
    @IBOutlet weak var titleLabel: SPWhiteTextLabel!
    @IBOutlet weak var descLabel: SPWhiteTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        self.productImageView.clipsToBounds = true
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
