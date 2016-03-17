//
//  LeftMenuDetailCell.swift
//  twshopping
//
//  Created by Kevin on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class LeftMenuDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: SPWhiteTextLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func userSelected(selected:Bool){
        if selected {
            self.titleLabel.textColor = UIColor(red: 247.0/255.0, green: 202.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        }else{
            self.titleLabel.textColor = UIColor.whiteColor()
        }
    }

}
