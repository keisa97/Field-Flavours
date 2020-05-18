//
//  HomeViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 26/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class HomeViewController: UIViewController {

    @IBOutlet weak var userEmailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        var currentUserSigned = Auth.auth().currentUser
        
        let userEmail = currentUserSigned?.email
        
        //userEmailLabel.text = userEmail!
        
        
        
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

}
