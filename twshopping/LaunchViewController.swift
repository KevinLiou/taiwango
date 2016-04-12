//
//  LaunchViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
//import AVOSCloud

class LaunchViewController: UIViewController, UIAlertViewDelegate {
    
    
//    let app = "https://itunes.apple.com/us/app/tai-wan-gou/id1095562394?l=zh&ls=1&mt=8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SPTools.showLoadingOnViewController(self)
        
        SPService.sharedInstance.requestAllAPIMessageWith(["language":1, "app_name":"twshopping_ios"]) { (response) in
            
            if let tw_JSON = response.result.value {

                SPDataManager.sharedInstance.deleteLanguageWithPredicate(predicate: nil)
                SPDataManager.sharedInstance.insertAllData(data: tw_JSON, lan: "1")
        
                
                SPService.sharedInstance.requestAllAPIMessageWith(["language":2, "app_name":"twshopping_ios"]) { (response) in
                    if let ch_JSON = response.result.value {
                        SPDataManager.sharedInstance.insertAllData(data: ch_JSON, lan: "2")
                        
                        //update type 1, 2, 3
                        let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())'")
                        let version = SPDataManager.sharedInstance.fetchAppInfoWithPredicate(predicate: predicate)
                        
                        //                            "Type = 1, 顯示訊息
                        //                            Type = 2, 顯示訊息,不強制更新
                        //                            Type = 3, 顯示訊息,強制更新
                        //                            Type = 4, 無"
                        
                        if let type = version?.type, let info = version?.info{
                            
                            switch Int(type){
                            case 1:
                                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleNotify",comment: ""),
                                                            message: info,
                                                            delegate: nil,
                                                            cancelButtonTitle: nil,
                                                            otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                                alertView.show()
                                self.entry()
                            case 2:
                                let vString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
                                
                                if vString != version?.version {
                                    let alertView = UIAlertView(title: NSLocalizedString("AlertTitleNotify",comment: ""),
                                                                message: info,
                                                                delegate: self,
                                                                cancelButtonTitle: NSLocalizedString("ButtonTitleNotNow",comment: ""),
                                                                otherButtonTitles: NSLocalizedString("ButtonTitleGoUpdate",comment: ""))
                                    alertView.delegate = self
                                    alertView.tag = 2
                                    alertView.show()
                                }else{
                                    self.entry()
                                }
                                
                                
                            case 3:
                                
                                let vString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
                                
                                if vString != version?.version {
                                    let alertView = UIAlertView(title: NSLocalizedString("AlertTitleNotify",comment: ""),
                                                                message: info,
                                                                delegate: self,
                                                                cancelButtonTitle: nil,
                                                                otherButtonTitles: NSLocalizedString("ButtonTitleGoUpdate",comment: ""))
                                    alertView.delegate = self
                                    alertView.tag = 3
                                    alertView.show()
                                }else{
                                    self.entry()
                                }
                            default:
                                self.entry()
                            }
                        }else{
                            self.entry()
                        }
                        
                    }
                    SPTools.hideLoadingOnViewController(self)
                }
                
                
                

            }
        }
    }
    
    func showError(){
        //error
        let alertView = UIAlertView(title: NSLocalizedString("AlertTitleErrorConn",comment: ""),
            message: NSLocalizedString("AlertMessageTryAgainLater",comment: ""),
            delegate: self,
            cancelButtonTitle: nil,
            otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
        alertView.tag = 1000
        alertView.show()
    }
    
    
    func entry(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let profile = SPDataManager.sharedInstance.fetchProfile()
        
        if let _ = profile {
            //登入過
            //...
            appDelegate.entryMainViewController()
        }else{
            //未登入
            //...
            appDelegate.entryLoginViewController()
        }
    }
    
    
    //MARK - UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if alertView.tag == 2 {

            if buttonIndex == 0{
                self.entry()
            }else{
                UIApplication.sharedApplication().openURL(NSURL(string: SPServiceHost.APPURL.rawValue)!)
                exit(0);
            }
            
        }else if alertView.tag == 3 {
            UIApplication.sharedApplication().openURL(NSURL(string: SPServiceHost.APPURL.rawValue)!)
            exit(0);
        }else if alertView.tag == 1000 {
            exit(0);
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
