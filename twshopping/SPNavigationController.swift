//
//  SPNavigationController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class SPNavigationController: UINavigationController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup(){

//        // Sets background to a blank/empty image
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nav"), forBarMetrics: .Default)
//        // Sets shadow (line below the bar) to a blank image
//        UINavigationBar.appearance().shadowImage = UIImage()
//        // Sets the translucent background color
////        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
//        // Set translucent. (Default value is already true, so this can be removed if desired.)
//        UINavigationBar.appearance().translucent = true
        
        
        
        
        
        self.navigationBar.setBackgroundImage(UIImage(named: "nav"), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true

        
        
        
        self.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
