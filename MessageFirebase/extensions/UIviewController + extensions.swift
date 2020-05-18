//
//  UIviewController + extensions.swift
//  MessageFirebase
//
//  Created by shahar keisar on 13/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
import PKHUD
protocol ShowHUD {
    //abstract methods
}

//3.2)add concrete methods to your protocol:
extension ShowHUD{
    func showProgress(title: String? = nil, subTitle: String? = nil){
        HUD.show(.labeledProgress(title: title, subtitle: subTitle))
    }
    
    func showError(title: String, subTitle: String? = nil){
        HUD.flash(.labeledError(title: title, subtitle: subTitle), delay: 3)
    }
    
    //validation email must be valid
    func showLabel(title: String){
        HUD.flash(.label(title), delay: 1)
    }
    
    func showSuccess(title: String? = nil, subTitle: String? = nil){
        HUD.flash(.labeledSuccess(title: title, subtitle: subTitle), delay: 1)
    }
}
//3.3) assign this method to selected view controllers
extension UIViewController: ShowHUD{}
//methods for register / login?

//add ore to show HUD
protocol UserValidation: ShowHUD {
    var emailTextField: UITextField!{get}
    var passwordTextField: UITextField!{get}
    //check that password text field has text

}


//2) add functionality to your protocol
extension UserValidation{
    var isEmailValid: Bool{
        
        //if email is not valid -> show message for 1 second *(also return false)
        guard let email = emailTextField.text, !email.isEmpty else{
            showLabel(title: "Email must not be empty")
            return false
        }
        //email is valid -> return type
        return true
    }
    
    var isPasswordValid: Bool{
           //if password is not valid -> show message for 1 second *(also return false)
           guard let password = passwordTextField.text, !password.isEmpty else{
               showLabel(title: "password must not be empty")
               return false
           }
        
           //password is valid -> return type
           return true
       }
}
//3) add functuionality to your viewcontrollers

extension LoginViewController: UserValidation{}
extension SignUpViewController: UserValidation{}

   




