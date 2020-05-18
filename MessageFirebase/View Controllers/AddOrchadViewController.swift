//
//  AddOrchadViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 30/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import Firebase
import MapKit


class AddOrchadViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var addOrchadButtonOutlet: UIButton!
    
    @IBAction func addOrchadButton(_ sender: UIButton) {
        
        let orchadName = OrchadNameTextField.text ?? ""
        print(orchadName)
        let orchadFruits = OrchadFruitsTextField.text ?? ""
        print(orchadFruits)
//        finalOrchad = Orchard(orchadName: orchadName, fruitsAvailable: orchadFruits,
//                              longitude: longitude, latitude: latitude)
        
//        OrchardDataSource().addOrchad(
//            orchard: finalOrchad ?? Orchard(orchadName: "basic", fruitsAvailable: "basic",
//                                            longitude: 1.1, latitude: 1.1))
        
        
        transitionToHome()
    }
    
    
    
    @IBOutlet weak var OrchadFruitsTextField: UITextField!
    @IBOutlet weak var OrchadNameTextField: UITextField!
    
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var backgroundImages = [UIImage]()

    var counter = 0
    @objc func swipeRightImageHandle(_ sender: UISwipeGestureRecognizer){
        print("check if any array in Func")
            backgroundImages = [#imageLiteral(resourceName: "apricots tree"),#imageLiteral(resourceName: "orachad item backround"),#imageLiteral(resourceName: "peach tree"),#imageLiteral(resourceName: "banana tree"),#imageLiteral(resourceName: "cherry tree item background"),#imageLiteral(resourceName: "pears tree"),#imageLiteral(resourceName: "apple tree")]
        backgroundImageView.image = #imageLiteral(resourceName: "apple tree")
        //backgroundImageView.image = backgroundImages[counter % backgroundImages.count]
            print(counter % backgroundImages.count)
            print("imageCount ", counter )
            counter += 1
        
    }
    
    @IBOutlet weak var scrollViewContainer: UIView!
    
    var longitude: Double = 1.1
    var latitude: Double = 1.1
    
    @IBOutlet weak var mapView: MKMapView!
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        sender?.numberOfTouchesRequired = 1
        let touchLocation = sender!.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        longitude = locationCoordinate.longitude
        latitude = locationCoordinate.latitude
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer){

        if sender.state == UIGestureRecognizer.State.ended {
            let touchLocation = sender.location(in: self.mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            return
        }
        else if sender.state == UIGestureRecognizer.State.began{
            let touchLocation = sender.location(in: self.mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        }
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        if (sender.state == UIGestureRecognizer.State.ended)
        {
            // handling code
            let touchLocation = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        }
    }
    func transitionToHome(){
        let homeViewController =
            self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    func setUpElements(){
        
        
        Utilities.styleTextField(OrchadNameTextField)
        Utilities.styleTextField(OrchadFruitsTextField)
        Utilities.styleFilledButton(addOrchadButtonOutlet)
    }
    //var finalOrchad: Orchard?
    
    func buildOrchadForUpload(){
        let orchadName = OrchadNameTextField.text ?? ""
        print(orchadName)
        let orchadFruits = OrchadFruitsTextField.text ?? ""
        print(orchadFruits)
        
//        finalOrchad = Orchard(orchadName: orchadName, fruitsAvailable: orchadFruits,
//                              longitude: 1.1, latitude: 1.1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.allowableMovement = 15 // 15 points
        longPressGesture.delegate = self
        self.mapView.addGestureRecognizer(longPressGesture)
        

        setUpElements()
        //buildOrchadForUpload()
        
        print("check if any array in viewDidLoad")

        backgroundImages = [#imageLiteral(resourceName: "apricots tree"),#imageLiteral(resourceName: "orachad item backround"),#imageLiteral(resourceName: "peach tree"),#imageLiteral(resourceName: "banana tree"),#imageLiteral(resourceName: "cherry tree item background"),#imageLiteral(resourceName: "pears tree"),#imageLiteral(resourceName: "apple tree")]

        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightImageHandle(_:)))
        //swipeRightGesture.direction = .right
        backgroundImageView.addGestureRecognizer(swipeRightGesture)
        
        //for i in 0..<backgroundImages.count{
                    
        //            let imageView = UIImageView()
        //            imageView.image = backgroundImages[i]
        //            let xPosition = self.view.frame.width * CGFloat(i)
        //            imageView.frame = CGRect(x: xPosition, y: 0, width: self.imageScrollView.frame.width, height: self.imageScrollView.frame.height)
        //            imageView.contentMode = .scaleAspectFill
        //
        //
        //
        //            imageScrollView.delegate = self
        //            imageScrollView.isScrollEnabled = true
        //            imageScrollView.isPagingEnabled = true
        //            imageScrollView.contentSize.width = imageScrollView.contentSize.width * CGFloat(i + 1)
        //            imageScrollView.addSubview(imageView)
                    
                    
        //            NSLayoutConstraint.activate([
        //            imageScrollView.leftAnchor.constraint(equalTo: scrollViewContainer.leftAnchor),
        //            imageScrollView.rightAnchor.constraint(equalTo: scrollViewContainer.rightAnchor),
        //            imageScrollView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
        //            imageScrollView.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor)
        //            ])
                //}
        
        
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
