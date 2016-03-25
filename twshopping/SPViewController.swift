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
        if self.navigationController?.viewControllers.count > 1 {
            
            let image = UIImage(named: "icon_back")?.imageWithRenderingMode(.AlwaysOriginal)
            let backButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(SPViewController.pop))
            self.navigationItem.leftBarButtonItem = backButtonItem;
            
        }else{
            
            let image = UIImage(named: "icon_menu")?.imageWithRenderingMode(.AlwaysOriginal)
            let backButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(SPViewController.showMenu))
            self.navigationItem.leftBarButtonItem = backButtonItem;
            
        }
    }
    
    func pop(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func showMenu(){
        self.sideMenuViewController.presentLeftMenuViewController()
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
