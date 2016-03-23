//
//  SPValidator.swift
//  twshopping
//
//  Created by KevinLiou on 2016/3/22.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import Foundation
import Validator

class SPValidator {
    static func validatorWithEmail(email:String) -> Bool{
        
        let rule = ValidationRulePattern(pattern: ValidationPattern.EmailAddress, failureError: ValidationError(message: ""))
        let result = email.validate(rule: rule)
        
        if result.isValid == false || email.characters.count == 0 {
            
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                message:NSLocalizedString("AlertMessageEmailError",comment: "") ,
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            
            alertView.show()
        }
        
        return result.isValid
    }
    
    static func validatorWithPassword(password:String) -> Bool{

        let rangeLengthRule = ValidationRuleLength(min: 6, max: 12, failureError: ValidationError(message: ""))
        let result = password.validate(rule: rangeLengthRule)

        if result.isValid == false || password.characters.count == 0{
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                message: NSLocalizedString("AlertMessagePwdError",comment: ""),
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
        }
        
        return result.isValid
    }
    
    static func validatorWithTwoPassword(password:String, password2:String ) -> Bool{
        
        let result_pwd1 = SPValidator.validatorWithPassword(password)
        
        if result_pwd1 == true {
            
            if password == password2 {
                return true
            }else{
                let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                    message: NSLocalizedString("AlertMessage2PwdNotMatch",comment: ""),
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
                alertView.show()
                return false
            }
            
        }else{
            return false
        }
    }
    
    
    static func validatorWithName(name:String) -> Bool {
        
        let result = (name.characters.count < 31 || name.characters.count == 0/*非必填*/)
        
        if !result {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                message: NSLocalizedString("AlertMessageNameError",comment: ""),
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
        }
        
        return result
    }
    
    
    static func validatorWithAddress(address:String) -> Bool {
        let result = (address.characters.count < 251 || address.characters.count == 0/*非必填*/)
        
        if !result {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                message: NSLocalizedString("AlertMessageAddressError",comment: ""),
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
        }
        
        return result
    }
    
    static func validatorWithMobile(mobile:String) -> Bool {
        
        let result = (mobile.characters.count < 12 || mobile.characters.count == 0/*非必填*/)
        
        if !result {
            let alertView = UIAlertView(title: NSLocalizedString("AlertTitleError",comment: ""),
                message: NSLocalizedString("AlertMessageMobileError",comment: ""),
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: NSLocalizedString("ButtonTitleSure",comment: ""))
            alertView.show()
        }
        
        return result

    }
}
