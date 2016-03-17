//
//  LaunchViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SPTools.showLoadingOnViewController(self)
        
        
        let time: NSTimeInterval = 3.0
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
            
            //load data
            let bundle = NSBundle.mainBundle()
            if let path = bundle.pathForResource("json", ofType: "json") {
                if let jsonData = NSData(contentsOfFile: path) {
                    do{
                        
                        if let data = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableLeaves) as? [String:[String:[AnyObject]]] {
                            SPDataManager.sharedInstance.insertAllData(data: data)
                        }
                        
                    } catch {
                        //error
                    }
                }
            }
            
            //update type 1, 2, 3
            
            
            //登入過
            //...
            
            
            //未登入
            //...
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.entryLoginViewController()
            
            SPTools.hideLoadingOnViewController(self)
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
