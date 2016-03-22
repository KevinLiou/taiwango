//
//  LaunchViewController.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import AVOSCloud

class LaunchViewController: UIViewController, UIAlertViewDelegate {
    
    
    let app = "https://itunes.apple.com/us/app/tai-wan-gou/id1095562394?l=zh&ls=1&mt=8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SPTools.showLoadingOnViewController(self)
        
        
        let query = AVQuery(className: "API")
        query.getFirstObjectInBackgroundWithBlock { (object: AVObject!, error: NSError!) -> Void in
            let time: NSTimeInterval = 1.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                if object != nil {
                    let jsonString = object["data"] as? String
                    
                    if let json = jsonString{
                        do{
                            
                            if let data = try NSJSONSerialization.JSONObjectWithData(json.dataUsingEncoding(NSUTF8StringEncoding)!, options: .MutableLeaves) as? [String:[String:[AnyObject]]] {
                                SPDataManager.sharedInstance.insertAllData(data: data)
                            }else{
                                let alertView = UIAlertView(title: "連線發生錯誤！", message: "請稍候重新嘗試", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "確定")
                                alertView.tag = 1000
                                alertView.show()
                            }
                            
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
                                    let alertView = UIAlertView(title: "通知", message: info, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
                                    alertView.show()
                                    self.entry()
                                case 2:
                                    let alertView = UIAlertView(title: "通知", message: info, delegate: self, cancelButtonTitle: "暫時不要", otherButtonTitles: "前往更新")
                                    alertView.tag = 2
                                    alertView.show()
                                case 3:
                                    let alertView = UIAlertView(title: "通知", message: info, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "前往更新")
                                    alertView.tag = 3
                                    alertView.show()
                                default:
                                    self.entry()
                                }
                            }else{
                                self.entry()
                            }
                            
                        } catch {
                            //error
                        }
                    }//let json = jsonString
                }//object != nil
                
                
                SPTools.hideLoadingOnViewController(self)
            }
        }
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
                UIApplication.sharedApplication().openURL(NSURL(string: app)!)
                exit(0);
            }
            
        }else if alertView.tag == 3 {
            UIApplication.sharedApplication().openURL(NSURL(string: app)!)
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
