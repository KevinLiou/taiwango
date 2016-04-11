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
            return "2"
        }else{
            //繁體
            return "1"
        }
    }
    
    
    static func randomAlphaNumericString(length: Int) -> String {
        
//        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    
    static func getRandomSnString() -> String{
        let sn = "\(SPTools.randomAlphaNumericString(5))-\(Int(NSDate().timeIntervalSince1970*100000))"
        return sn
    }
    
    static func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}
