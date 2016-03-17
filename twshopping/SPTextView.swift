//
//  SPTextView.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

@IBDesignable
class SPTextView: UITextView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        self.editable = false
        self.selectable = true
        self.dataDetectorTypes = .All
        
        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsetsZero
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
