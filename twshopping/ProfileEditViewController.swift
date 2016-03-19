//
//  ProfileEditViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/19.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ProfileEditViewController: SPSingleColorViewController {
    
    var profile:Profile?

    @IBOutlet weak var nameTextField: SPTextField!
    @IBOutlet weak var emailTextField: SPTextField!
    @IBOutlet weak var addressTextField: SPTextField!
    @IBOutlet weak var mobileTextField: SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "詳細個人資料"
        
        let saveItem = UIBarButtonItem(title: "儲存", style: .Plain, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = saveItem
        
        
    }
    
    func save(){
        self.navigationController?.popViewControllerAnimated(true)
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
