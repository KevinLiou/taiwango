//
//  SPImageView.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class SPImageView: UIImageView {

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.3)
        self.contentMode = UIViewContentMode.ScaleAspectFill
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
