//
//  LoginViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit
import RESideMenu

@IBDesignable
class LoginViewController: SPSingleColorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK : Actions
    @IBAction func tapGoToRegister(sender: UITapGestureRecognizer) {
        let registerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController")
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
    
    @IBAction func tapPassLogin(sender: UITapGestureRecognizer) {
        entryMainViewController()
    }
    @IBAction func tapForgotPassword(sender: UITapGestureRecognizer) {
        let forgotPwdViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ForgotPwdViewController")
        self.navigationController?.pushViewController(forgotPwdViewController!, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func entryMainViewController(){
        //products
        
        //取回default 分類中的products
        let predicate = NSPredicate(format: "language.lan = '\(SPTools.getPreferredLanguages())'")
        let result = SPDataManager.sharedInstance.fetchCateWithPredicate(predicate: predicate)
        let cate = result?.first
        let products = cate!.product?.allObjects as! [Product]
        
        //取得需要的view controller
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navProductListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NavProductListViewController") as! SPNavigationController
        let leftMenuViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LeftMenuViewController")
        let productListViewController = navProductListViewController.viewControllers.first as! ProductListViewController
        
        //側邊選單init
        let sideMenuViewController = RESideMenu(contentViewController: navProductListViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
        sideMenuViewController.backgroundImage = UIImage(named: "Launch")
        
        //set第一個畫面的值
        productListViewController.dataSource = products
        productListViewController.title = cate!.name
        
        //更換app畫面
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        appDelegate.window?.rootViewController = sideMenuViewController
        appDelegate.window?.makeKeyAndVisible()
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
