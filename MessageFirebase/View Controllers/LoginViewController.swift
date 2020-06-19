//
//  LoginViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 26/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var showPassBtn: UIButton!
    
    @IBAction func showPass(_ sender: UIButton) {
        
        let secure = passwordTextField.isSecureTextEntry
        
        if secure {
            showPassBtn.setTitle("👓", for: .normal)
            secure == true
        }else{
            showPassBtn.setTitle("🕶", for: .normal)
            secure == true
        }
        

        
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements(){
    errorLabel.alpha = 0
    
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleFilledButton(loginButton)
    }
    
    func transitionToHome(){
        let homeViewController =
            self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        passwordTextField.isSecureTextEntry = true
        setUpElements()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: UIButton) {
       
//        //create cleaned versions of the text field
//        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
        guard isEmailValid && isPasswordValid,
        let email = emailTextField.text,
        let password = passwordTextField.text else {return}
        
        showProgress(title: "Please Wait...")
        //dont allow the user to click twice
        sender.isEnabled = false
        
        //firebase:
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            //error:
            guard let _ = result else{
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                let errorMessageForUser = "email or password invalid"
                
                self?.showError(title: errorMessageForUser)
                sender.isEnabled = true
                return
            }
            
            //success
            self?.showSuccess()
            Router.shared.chooseMainViewController()
        }
        //sighin
        
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//
//
//            if error != nil{
//                //coulnt signIn
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            }
//            else {
//                self.transitionToHome()
//                print("login succsses")
//
//            }
//        }
    }
}


