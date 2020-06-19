//
//  TabBarViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 17/06/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController ,  UITabBarControllerDelegate{


        override func viewDidLoad() {
            super.viewDidLoad()
            //delegate = self
        }

        

        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            viewControllers?.forEach{
                $0.navigationController?.popToRootViewController(animated: false)
            }
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


