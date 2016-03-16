//
//  SPWhiteTextLabel.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/16.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

@IBDesignable
class SPWhiteTextLabel: UILabel {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
    }
    */


}
