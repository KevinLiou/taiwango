//
//  SPTools.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/15.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import UIKit

class SPTools {
    
    static func showLoadingOnViewController(viewController: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Tools", bundle: nil)
        let loadingViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoadingViewController")
        viewController.presentViewController(loadingViewController, animated: false, completion: nil)
    }
    
    static func hideLoadingOnViewController(viewController: UIViewController){
        if (viewController.presentedViewController?.isKindOfClass(LoadingViewController) == true) {
            viewController.dismissViewControllerAnimated(false, completion: nil)
        }
        
    }
    
    static func getPreferredLanguages() -> String {
        let language = NSLocale.preferredLanguages()[0]
        if language.hasPrefix("zh-Hans") {
            //簡體
            return "ch"
        }else{
            //繁體
            return "tw"
        }
    }
}
