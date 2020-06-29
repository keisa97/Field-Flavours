//
//  AddOrchardSetDetailsViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 12/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddOrchardSetDetailsViewController:  UIViewController {

    var orchard : OrchardModel?
    //var orchardName : String = ""
    
    var editMode: Bool = false

    
    @IBOutlet weak var OrchardNameTextField: UITextField!
    
    @IBOutlet weak var OrchadFruitsTextField: UITextField!
    
    @IBOutlet weak var ContactNumberTextField: UITextField!
//    Todo: build lanscape mode
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .portrait
//    }
//
//    override var shouldAutorotate: Bool{
//        false
//    }
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            //EULA
            Router.shared.chooseMainViewController()
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    @IBOutlet weak var nextPageButton: UIButton!
    
    
    
    @IBAction func NextPageButton(_ sender: UIButton) {
        
//        guard let orchardName = OrchardNameTextField.text, !orchardName.isEmpty,
//              let orchardFruits = OrchadFruitsTextField.text, !orchardFruits.isEmpty,
//              let contactNumber = ContactNumberTextField.text, !contactNumber.isEmpty,
//              let detailsAboutOrchard = DetailsAboutOrchardTextField.text, !detailsAboutOrchard.isEmpty
//
//            else {
//           // show an alert
//           return
//        }
        if validateFields(){
            performSegue(withIdentifier: "addOrchardSegue", sender: nil)
            //  [orchardName, orchardFruits,contactNumber,detailsAboutOrchard]

        }

            
        
    }
    
    func setUpElements(){
        //errorLabel.alpha = 0
        
//        Utilities.styleTextField(OrchardNameTextField)
//        Utilities.styleTextField(OrchadFruitsTextField)
//        Utilities.styleTextField(ContactNumberTextField)
        //Utilities.styleTextField(DetailsAboutOrchardTextField)
        Utilities.styleFilledButton(nextPageButton)
        descriptionTextView.clipsToBounds = true;
        descriptionTextView.layer.cornerRadius = 10.0;
        
    }
    
    func validateFields() -> Bool{
        if editMode {
            nextPageButton.isEnabled = true}
            else{
                nextPageButton.isEnabled = false
                }
            

        //check that all fields are filled in
        if
              OrchardNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                OrchadFruitsTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                ContactNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                descriptionTextView.text == "you may set a description for your orchard here"
        {
            //descriptionTextView.textColor = .red
            //descriptionTextView.text == "*you may set a description for your orchard here*"
            let err = "please fill all the fields"
            //showError(title: err)
            return false
            
        }
        nextPageButton.isEnabled = true

        return true
        
    }
    
    
    func checkForEditMode(){
        if editMode {
            OrchardNameTextField.isUserInteractionEnabled = false
            OrchardNameTextField.text = orchard?.orchadName
            
            OrchadFruitsTextField.text = orchard?.fruitsAvailable
            
            ContactNumberTextField.text = orchard?.contactNumber
            
            descriptionTextView.text = orchard?.orchardDescription
        }else{
          OrchardNameTextField.text = ""
          OrchadFruitsTextField.text =  ""
          ContactNumberTextField.text = ""
          descriptionTextView.text =  ""
            
        }
        
    }

    var textFields : [UITextField] = []
    
    @objc func textFieldDidChange(_ textField: UITextField) {
      //set Button to false whenever they begin editing
        if (editMode){ nextPageButton.isEnabled = true }
            else{
                nextPageButton.isEnabled = false
            }
        
        guard let first = textFields[0].text, first.count > 2 else {
            print("textField 1 is empty")
        //textFields[0].placeholder = "*"
        //textFields[0].textColor = .red
            return
        }
        guard let second = textFields[1].text, second != "" else {
            print("textField 2 is empty")
            //textFields[1].placeholder = "*"
            //textFields[1].textColor = .red
            return
        }
        guard let third = textFields[2].text, third != "" else {
            print("textField 3 is empty")
            //textFields[2].placeholder = "*"
            //textFields[2].textColor = .red
            return
        }
        
        // set button to true whenever all textfield criteria is met.
        for textfield in textFields{
            textfield.textColor = .black
        }
        nextPageButton.isEnabled = true

    }
    
    weak var window: UIWindow? //window show login, window show chat

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        print("orchard", orchard)
        
        validateFields()
    
        
        setUpElements()
        checkForEditMode()
        
        textFields  = [OrchardNameTextField, OrchadFruitsTextField, ContactNumberTextField]
        for textfield in textFields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
        
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addOrchardSegue" {
           let dest = segue.destination as! AddOrchardLocationAndImageViewController
            if (editMode){
                dest.seguedOrchard = OrchardModel(orchardOwnerID: orchard!.orchardOwnerID ,
                                            orchadName: orchard?.orchadName as! String,
                                            fruitsAvailable: OrchadFruitsTextField.text ?? orchard?.fruitsAvailable as! String,
                                            orchardDescription: descriptionTextView.text ?? orchard?.orchardDescription as! String,
                                            latitude: orchard!.latitude, longitude: orchard!.longitude,
                                            contactNumber : ContactNumberTextField.text ??  orchard?.contactNumber as! String)
// ,imageURL : orchard!.orchardImageBackgroundImageURL as! String ?? "")
                dest.editMode = true
            
                
            }else{
                
            dest.orchardName = OrchardNameTextField.text ?? ""
            dest.orchardFruits = OrchadFruitsTextField.text ?? ""
            dest.contactNumber = ContactNumberTextField.text ?? ""
            dest.detailsAboutOrchard = descriptionTextView.text ?? ""
            //dest.delegate = self
            }

        }
    }
}



//extension AddOrchardSetDetailsViewController: EditingFinish{
//    func didFinish(isFinish: Bool) {
//        if isFinish {
//            self.dismiss(animated: true)
//            self.navigationController?.navigationController?.popToRootViewController(animated: true)
//        }
//    }
//}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
