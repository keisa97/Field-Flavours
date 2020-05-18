//
//  WhyDoesAppleExiestViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 05/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit

class WhyDoesAppleExiestViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var backgroundImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImages = [#imageLiteral(resourceName: "apricots tree"),#imageLiteral(resourceName: "orachad item backround"),#imageLiteral(resourceName: "peach tree"),#imageLiteral(resourceName: "banana tree"),#imageLiteral(resourceName: "cherry tree item background"),#imageLiteral(resourceName: "pears tree"),#imageLiteral(resourceName: "apple tree")]

        
        
        
        for i in 0..<1{
                    
                    imageView.image = backgroundImages[i]
                    let xPosition = self.view.frame.width * CGFloat(i)

                    imageView.contentMode = .scaleAspectFill
                     let swipeRightGesture = UISwipeGestureRecognizer(target: self, action:             #selector(swipeRightImageHandle(_:)))
                     //swipeRightGesture.direction = .right
                     imageView.addGestureRecognizer(swipeRightGesture)
        
        
    
        }

        // Do any additional setup after loading the view.
        
    }
    var counter = 0
    
    var imageView = UIImageView()

    @objc func swipeRightImageHandle(_ sender: UISwipeGestureRecognizer){
        
            imageView.image = backgroundImages[counter % backgroundImages.count]
            print(counter % backgroundImages.count)
            print("imageCount ", counter )
            counter += 1
        
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
