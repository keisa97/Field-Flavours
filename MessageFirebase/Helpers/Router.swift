//
//  Router.swift
//  MessageFirebase
//
//  Created by shahar keisar on 13/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth
//האם להציג לוגין או צאט

class Router{
    //properties:
    //the apps main window(windows show view controllers)
    weak var window: UIWindow? //window show login, window show chat
    
    //is the user logged in or not(computed poperty):
    var isLoggedIn: Bool{
        return Auth.auth().currentUser != nil // if we got user -> return true
    }
    
    static let shared = Router()
    //inits
    //private init -> singleton
    private init(){ }
    
    func chooseMainViewController(){
        //make sure that we are on the UI Thread.
        
        guard Thread.current.isMainThread else {
            //call this method again on the UI thread:
            DispatchQueue.main.async {
                self.chooseMainViewController()
            }
            return
        }
        
        //when we get to this line - we can be sure that we are on the UI thread
        //UI Thread:
        
        let fileName = isLoggedIn ? "UserBoard" : "Main"
        let sb = UIStoryboard(name: fileName, bundle: .main)
        
        window?.rootViewController = sb.instantiateInitialViewController()
    }
    
    func UnsignedUserViewcontroller(){
        //make sure that we are on the UI Thread.
        
        guard Thread.current.isMainThread else {
            //call this method again on the UI thread:
            DispatchQueue.main.async {
                self.UnsignedUserViewcontroller()
            }
            return
        }
        
        //when we get to this line - we can be sure that we are on the UI thread
        //UI Thread:
        print("On Main Thread")
        let sb = UIStoryboard(name: "OrchardMain", bundle: .main)
        print("To OrchardMain")

        sb.instantiateInitialViewController()
        self.window?.rootViewController = sb.instantiateInitialViewController()
        print(window)
        //window?.rootViewController?.show(sb, sender: nil)
        //self.show(sb!, sender: self)


    }
        
    
}


//simple ideas:
//Login is the entry point -> Login -> Main
//Main is the entry point -> Main -> Login

//better: or login or main
//1) the user never goes to the resricted area

//2) Drop in solution (can copy easy to other projects)

//3) guard let user = ...currect user else {Router}
