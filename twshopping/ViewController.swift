//
//  ViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/7.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testObject = AVObject(className: "TestObject")
        testObject.setObject("object", forKey: "key")
        testObject.save()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

