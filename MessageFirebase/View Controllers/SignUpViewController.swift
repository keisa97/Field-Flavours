//
//  SignUpViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 26/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var singUpButton: UIButton!
    
    
    @IBAction func passwordTextFieldReturn(_ sender: UITextField) {
        self.view.endEditing(true)
        
    }
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(singUpButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        setUpElements()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func validateFields() -> String?{
        
        //check that all fields are filled in
        if
            firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
            return "please fill in all fields"
        }
        
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //password isn't seure enought
            return " Please make sure your password is at least 8 characters, cntains a special character and a number"
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
//
//        //validate the fields
//        let error = validateFields()
//
//        if error != nil {
//            // There is somthing worng in the fields, show error message
//            showError(error!)
//        }
//        else{
//        //create cleaned versions of the data
//            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        //create the user
//            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//
//                //check for errors
//                if err != nil {
//
//                    //there wasn't error creating the user
//                    self.showError("Error creating User")
//                }
//                else{
//                    //user was created successfully, now store the first name and last name
//                    //by - Firestore Cloud
//                    let db = Firestore.firestore()
//                    //let dbRealTime = Database.database().reference()
//                        //self.dbRealTime.child("users").child(user.uid).setValue(["username": username])
//                        db.collection("users").addDocument(data:
//                        ["first_name":firstName, "last_name":lastName
//
//                            , "uid": result!.user.uid ]) {(error) in
//                        if error != nil{
//                            //show error message if could not success creating user
//                            self.showError("Error saving user data")
//                        }
//                    }
//            // if user create successfully bring signed user to the home page - (HomeViewController)
//                //transition to the home screen
//                    //self.transitionToHome()
//                    //success
//                    //
//                    //self?.showSuccess()
//                    Router.shared.chooseMainViewController()
//
//               }
//
//            }
//
//        }
        
            guard isEmailValid && isPasswordValid,
                let email = emailTextField.text,
                let password = passwordTextField.text else {return}
            
            //may be empty
            var nickname = firstNameTextField.text!
            
            //if the nickName is empty (split the email)
            
            nickname = !nickname.isEmpty ? nickname : String(email.split(separator: "@")[0])
            
            showProgress(title: "Please Wait...")
            //dont allow the user to click twice
            sender.isEnabled = false
            
            //firebase:
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                //error:
                guard let result = result else{
                    let errorMessage = error?.localizedDescription ?? "Unknown error"
                    
                    self?.showError(title: errorMessage)
                    sender.isEnabled = true
                    return
                }
                
                //success:
                //we didn't ise the nickname
                
                let user = result.user
                
                //update nickname:
                let profileChangeRequset = user.createProfileChangeRequest()
                profileChangeRequset.displayName = nickname
                //apply the nickname(profile change requst)
                profileChangeRequset.commitChanges { (error) in
                    //check if error
                    if let error = error {
                        let text = error.localizedDescription
                        self?.showError(title: "Register Failed", subTitle: text)
                    }else{
                        self?.showSuccess()
                        //goto UserBoard
                        Router.shared.chooseMainViewController()//todo: fix the router
                    }
                }
                
                
            }
            
            
            
        

        
    }
    
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
