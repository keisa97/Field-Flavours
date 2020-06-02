//
//  NavController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 17/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit

class PortraitNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .portrait
//    }
//    
//    override var shouldAutorotate: Bool{
//        false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PortraitNavController {

    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var shouldAutorotate: Bool{
        false
    }
    


//    override open var shouldAutorotate: Bool {
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.shouldAutorotate
//            }
//            return super.shouldAutorotate
//        }
//    }
//
//    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.preferredInterfaceOrientationForPresentation
//            }
//            return super.preferredInterfaceOrientationForPresentation
//        }
//    }
//
//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.supportedInterfaceOrientations
//            }
//            return super.supportedInterfaceOrientations
//        }
//    }

}
