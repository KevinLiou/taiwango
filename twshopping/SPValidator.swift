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
            let alertView = UIAlertView(title: "錯誤", message:"Email格式錯誤" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
            alertView.show()
        }
        
        return result.isValid
    }
    
    static func validatorWithPassword(password:String) -> Bool{

        let rangeLengthRule = ValidationRuleLength(min: 6, max: 12, failureError: ValidationError(message: ""))
        let result = password.validate(rule: rangeLengthRule)

        if result.isValid == false || password.characters.count == 0{
            let alertView = UIAlertView(title: "錯誤", message:"密碼請輸入6~12位英文或數字" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
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
                let alertView = UIAlertView(title: "錯誤", message:"兩次密碼輸入不相符" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
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
            let alertView = UIAlertView(title: "錯誤", message:"姓名最多30的字" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
            alertView.show()
        }
        
        return result
    }
    
    
    static func validatorWithAddress(address:String) -> Bool {
        let result = (address.characters.count < 251 || address.characters.count == 0/*非必填*/)
        
        if !result {
            let alertView = UIAlertView(title: "錯誤", message:"地址最多250的字" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
            alertView.show()
        }
        
        return result
    }
    
    static func validatorWithMobile(mobile:String) -> Bool {
        
        let result = (mobile.characters.count < 12 || mobile.characters.count == 0/*非必填*/)
        
        if !result {
            let alertView = UIAlertView(title: "錯誤", message:"手機號最多11的字" , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "確定")
            alertView.show()
        }
        
        return result

    }
}
