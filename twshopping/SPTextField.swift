//
//  SPTextField.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

@IBDesignable
class SPTextField: UITextField {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.9)])
        self.backgroundColor = UIColor.clearColor()
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @IBInspectable var image : UIImage?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = self.frame.size.height/2.0
        
        if image != nil {
            let emailImageView = UIImageView(image: image)
            emailImageView.frame = CGRectMake(0, 0, emailImageView.image!.size.width + 10.0, emailImageView.image!.size.height)
            emailImageView.contentMode = .Right
            self.leftView = emailImageView
            self.leftViewMode = .Always
        }
    }


}
