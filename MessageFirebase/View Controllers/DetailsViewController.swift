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

class DetailsViewController: UIViewController {
    
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
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var contactNUmberLabel: UILabel!
    @IBOutlet weak var backgroundImageView: RoundImageView!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        detailsLabel.text = orchard.orchardDescription
        //contactNUmberLabel.text 
        //detailsLabel.text = landMark.shortDescription
        
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

}
