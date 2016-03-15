//
//  SPButton.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

@IBDesignable
class SPButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = self.frame.size.height/2.0
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.clipsToBounds = true
    }
    

}
