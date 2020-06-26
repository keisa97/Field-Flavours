//
//  DetailsViewController.swift
//  Lec14Location
//
//  Created by shahar keisar on 26/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAuth

class DetailsViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            //EULA
            Router.shared.chooseMainViewController()
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    //var landMark: LandMark?
    var orchard : OrchardModel?

    @IBOutlet weak var orchardNameLabel: UILabel!
    
    @IBOutlet weak var fruitsLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var contactNUmberLabel: UILabel!
    
    @IBAction func callBtn(_ sender: UIButton) {
        
        
        guard let number = URL(string: "tel://" + orchard!.contactNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBOutlet weak var backgroundImageView: RoundImageView!
    
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var navigateBtn: UIButton!
    //    @IBAction func website(_ sender: UIButton) {
//        guard let url =
//            URL(string: landMark?.productURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else{return}
//        print(url)
//        let sfVC = SFSafariViewController(url: url)
//        present(sfVC, animated: true)
//
//    }
    
    
    @IBAction func Navigate(_ sender: UIButton) {
        guard let orchard = orchard,
            let url = URL(string:    "http://maps.apple.com/?daddr=\(orchard.coodrinate.latitude),\(orchard.coodrinate.longitude)") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func editTransication(){
        let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
        navController.popToRootViewController(animated: true)
        let vc = navController.topViewController
            as!AddOrchardSetDetailsViewController
        
        
        
        
        vc.orchard = orchard
        vc.editMode = true
        tabBarController?.selectedIndex = 1
        vc.tabBarController?.delegate = self
        //performSegue(withIdentifier: "updateOrchardSegue", sender: nil)
    }
    
    
    @IBAction func editOrchardBtn(_ sender: UIButton) {
            
        //editTransication()
        
//        let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
//        //navigationController?.popToRootViewController(animated: true)
//        navController.popToRootViewController(animated: true)
//
//        let vc = navController.topViewController as!AddOrchardSetDetailsViewController
//
//
//        self.navigationController?.dismiss(animated: true, completion: {
//             self.navigationController?.popToRootViewController(animated: true)
//        })
        
//        let sb = UIStoryboard(name: "UserBoard", bundle: .main)
//        guard let vc = sb.instantiateViewController(identifier: "UserBoard") as?
//            AddOrchardSetDetailsViewController else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//
//
//
//        vc.orchard = orchard
//        vc.editMode = true
//        self.tabBarController?.view.reloadInputViews()
//
//        tabBarController?.selectedIndex = 1
//        vc.tabBarController?.delegate = self
//        present(vc, animated: true)
//        view.window?.rootViewController = vc

        //self.navigationController?.popToRootViewController(animated: true)
//              self.tabBarController?.viewControllers![1] as! UINavigationController
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: "AddOrchardSetDetailsViewController") as? AddOrchardSetDetailsViewController
//        view.window?.rootViewController = vc
        
        performSegue(withIdentifier: "updateOrchardSegue", sender: nil)
        
//        let addViewContoroller =
//            self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.AddOrchardSetDetailsViewController) as? AddOrchardSetDetailsViewController
//
//        self.view.window?.rootViewController = addViewContoroller
//        self.view.window?.makeKeyAndVisible()
        
        
        
        
        
        
        

        
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(navigateBtn)
        if editBtn != nil {
        Utilities.styleHollowButton(editBtn)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        // Do any additional setup after loading the view.
//        guard let landMark = landMark else{
//            return
//        }
        
        guard let orchard = orchard else{
            return
        }
        
        orchardNameLabel.text = orchard.orchadName
        //orchardNameLabel.backgroundColor = landMark.type.color
        //orchardNameLabel.textColor = .white
        
        //circle:
        orchardNameLabel.layer.cornerRadius = orchardNameLabel.frame.height / 2
        orchardNameLabel.layer.masksToBounds = true
        
        fruitsLabel.text = orchard.fruitsAvailable
        
        contactNUmberLabel.text = "Contact number: \(orchard.contactNumber)"
        descriptionLabel.text = orchard.orchardDescription
        //contactNUmberLabel.text 
        //descriptionLabel.text = landMark.shortDescription
        
        let ref = orchard.imageRef
        //if we have an image load it
        if let _ = orchard.orchardImageBackgroundImageURL{
            backgroundImageView.sd_setImage(with: ref)
            
            //placeholder:
            backgroundImageView.sd_setImage(with: ref, placeholderImage: #imageLiteral(resourceName: "apple tree"))
        }else{
            //could get ref
            backgroundImageView.image = #imageLiteral(resourceName: "apple tree")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "updateOrchardSegue" {
//           let dest = segue.destination as! AddOrchardSetDetailsViewController
//            dest.editMode = true
//            dest.orchard = orchard
//            tabBarController?.selectedIndex = 1
//            dest.tabBarController?.delegate = self
////            dest.orchardName = orchardNameLabel.text ?? ""
////            dest.OrchadFruitsTextField.text = fruitsLabel.text ?? ""
////            dest.ContactNumberTextField.text = contactNUmberLabel.text ?? ""
////            dest.descriptionTextView.text = descriptionLabel.text ?? ""
//            
//            //dest.delegate = self
//            
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "updateOrchardSegue" {
               let dest = segue.destination as! AddOrchardSetDetailsViewController
               
    // ,imageURL : orchard!.orchardImageBackgroundImageURL as! String ?? "")
                    dest.editMode = true
                    dest.orchard = orchard
                

            }
        }

}


