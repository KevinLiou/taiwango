//
//  SPViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class SPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let bgImageView = UIImageView(frame: self.view.bounds)
//        bgImageView.image = UIImage(named: "bg")
//        self.view.addSubview(bgImageView)
        
        if self.navigationController?.viewControllers.count > 1 {
            
            let image = UIImage(named: "icon_back")?.imageWithRenderingMode(.AlwaysOriginal)
            let backButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self.navigationController, action: Selector("popViewControllerAnimated:"))
            self.navigationItem.leftBarButtonItem = backButtonItem;
        }
        
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
