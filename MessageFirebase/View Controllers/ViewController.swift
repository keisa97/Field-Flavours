//
//  ViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 20/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import AVKit
import Firebase

class ViewController: UIViewController {
    
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var MloginButton: UIButton!
    
    @IBOutlet weak var continueButton: UIButton!
    
    func transitionToHome(){
        let homeViewController =
            self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func continueWithoutUser(_ sender: UIButton) {
        Router.shared.UnsignedUserViewcontroller()
        
        let storyboard = UIStoryboard(name: "OrchardMain", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        self.show(vc!, sender: self)
    }
    
    func setUpElements(){
     //errorLabel.alpha = 0
    
        Utilities.styleFilledButton(MloginButton)
        Utilities.styleHollowButton(signUpButton)
        Utilities.naturalButton(continueButton)

    }
    
    func setUpVideo(){
        
        //get the path to the resource in the bundle
        guard let bundlePath =  Bundle.main.path(forResource: "fieldTouchVideo", ofType: ".mp4") else {
            return
        }
        
        
        //create a URL from it
        
        let url = URL(fileURLWithPath: bundlePath)
        //create the video player item
        let videoItem = AVPlayerItem(url: url)
        //create the player
        videoPlayer = AVPlayer(playerItem: videoItem)
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //adujst the size and frame
        videoPlayerLayer?.frame = CGRect(
            x: -self.view.frame.size.width*1.4,
            y: 0,
            width: self.view.frame.size.width*4,
            height: self.view.frame.size.height)
        
//            videoPlayerLayer?.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: self.view.frame.size.width,
//            height: self.view.frame.size.height)
        
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // add it to the view and play it
        videoPlayer?.playImmediately(atRate: 1)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }

    

}

