//
//  SPSingleImageViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/17.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class SPSingleImageViewController: SPViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //單一背景圖片
        let bg_image = UIImage(named: "bg")
        self.view.layer.contents = bg_image?.CGImage
    }

}