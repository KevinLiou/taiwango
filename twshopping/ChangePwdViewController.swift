//
//  ChangePwdViewController.swift
//  twshopping
//
//  Created by Kevin on 2016/3/19.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class ChangePwdViewController: SPSingleColorViewController {

    @IBOutlet weak var oldPwdTextField: SPTextField!
    
    @IBOutlet weak var newPwdTextField: SPTextField!
    @IBOutlet weak var newPwdTextField2: SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("ButtonTitleChangePwd",comment: "")
        
        let saveItem = UIBarButtonItem(title: NSLocalizedString("ButtonTitleSure",comment: ""), style: .Plain, target: self, action: #selector(ChangePwdViewController.save))
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
