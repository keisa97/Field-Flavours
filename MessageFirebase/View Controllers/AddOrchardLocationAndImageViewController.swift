//
//  AddOrchardLocationAndImageViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 12/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

class AddOrchardLocationAndImageViewController: UIViewController {

    
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }

    
//    var delegate: EditingFinish?
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            //EULA
            Router.shared.chooseMainViewController()
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .satellite
            case 2:
                mapView.mapType = .hybrid
            default:
                break
        
        }
    }
    
    var longitude: Double = 1.1
    var latitude: Double = 1.1
    var annotation = MKPointAnnotation()
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        sender?.numberOfTouchesRequired = 1
        let touchLocation = sender!.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        longitude = locationCoordinate.longitude
        latitude = locationCoordinate.latitude
        
        //let annotation = Annotoation(coordinate: CLLocationCoordinate2DMake(longitude, latitude))
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        mapView.addAnnotation(annotation)
        //mapView.showAnnotations([annotation], animated: true)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
    }
    
    @IBOutlet weak var pickPhoto: UIButton!
    
    @IBAction func pickPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
            picker.delegate = self
            present(picker, animated: true, completion: nil)

    }
    
    @IBOutlet weak var orchardImage: RoundImageView!
    
    var orchardBackgroundImage = UIImage()
    
    var seguedOrchard : OrchardModel?
    var finalOrchard : OrchardModel?
    var editMode: Bool = false
    
    var orchardName : String!
    var orchardFruits : String!
    var contactNumber : String!
    var detailsAboutOrchard :String!
    
    
    @IBOutlet weak var btnFinishAndUpload: UIButton!
    
    @IBAction func finishAndUpload(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else {
        //todo:send user to login page
        return
        }
        showProgress()
        
        
        if (editMode){
            finalOrchard = seguedOrchard
        }else{
            
            finalOrchard = OrchardModel(orchardOwnerID: user.uid ,
                                   orchadName: orchardName,
                                   fruitsAvailable: orchardFruits,
                                   orchardDescription: detailsAboutOrchard,
                                   latitude: latitude, longitude: longitude,
                                   contactNumber : contactNumber)
        
        print(finalOrchard)
            }
        func afterOrchardSaved(_ err : Error?, _ success: Bool){
            if success{
                self.showSuccess()
                //delegate?.didFinish(isFinish: true)
                self.navigationController?.popToRootViewController(animated: true)
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "UserBoard")
                view.window?.rootViewController = vc
            }else{
                self.showError(title: "Please try again", subTitle: err?.localizedDescription)
                sender.isEnabled = true
                return
            }
        }
        
        if editMode {
            var snapshotKey = finalOrchard!.orchardOwnerID + (finalOrchard?.orchadName.replacingOccurrences(of: " ", with: ""))! ?? ""
            
            finalOrchard?.longitude = longitude
            finalOrchard?.latitude = latitude
            
            if let image = orchardImage.image{
                //we have an image:
                print("image to update" ,image)
                finalOrchard?.update(image: image, snapshotKey: snapshotKey, callback: afterOrchardSaved(_:_:))
            }else{
                //we got no image so use default image:
                finalOrchard?.update(snapshotKey: snapshotKey, callback: afterOrchardSaved(_:_:))
            }
        }
        
        
        if let image = orchardImage.image{
            //we have an image:
            finalOrchard?.save(image: image, callback: afterOrchardSaved(_:_:))
        }else{
            //we got no image so use default image:
            finalOrchard?.save(callback: afterOrchardSaved(_:_:))
        }
    }
    
    func setEditModeFields(){
        
        guard let ref = seguedOrchard?.imageRef else {return}
//        //if we have an image load it
        orchardImage.sd_setImage(with: ref)
        if let _ = seguedOrchard?.orchardImageBackgroundImageURL{
            orchardImage.sd_setImage(with: ref)
        }
    }
    
    
    func setUpElements(){
        //errorLabel.alpha = 0
        Utilities.pickButton(pickPhoto)
        Utilities.styleFilledGreenButton(btnFinishAndUpload)
    }
    
    //for annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        if (editMode){
            btnFinishAndUpload.setTitle("Finish Edits ✔︎", for: .normal)
            setEditModeFields()
            
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = LocationManager.shared.hasLocationPermission

        mapView.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .lightText
        //be the search delegate:
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Choose location"
        //searchController.searchBar.isTranslucent = true

        
        self.extendedLayoutIncludesOpaqueBars = !self.navigationController!.navigationBar.isTranslucent
        self.navigationController?.navigationBar.isHidden = false

        
        
        
        //add the seatch to our nav controller
        navigationItem.searchController = searchController
//        searchController.hidesNavigationBarDuringPresentation = false
        
//        searchController.definesPresentationContext = true
        print(orchardName,orchardFruits,contactNumber , detailsAboutOrchard)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            searchController.searchBar.delegate = self
        if (editMode){
            setEditModeFields()
            let place = MKPointAnnotation()
            place.title = "last location"
            place.coordinate = CLLocationCoordinate2D(latitude: seguedOrchard!.latitude, longitude: seguedOrchard!.longitude)
            mapView.addAnnotation(place)
            
        }
        navigationItem.searchController?.isActive = true
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

extension AddOrchardLocationAndImageViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //get the text
        guard let text = searchBar.text, text.count > 0 else {return}
        print(text)
        
        //text to location - GeoCoder
        let coder = CLGeocoder()
        coder.geocodeAddressString(text) {[weak self] (placeMarkArray, err) in
            //check that the array is not empty
            guard let place = placeMarkArray?.first , let location = place.location else {return}
            //add annotation to the map:
            //place.administrativeArea
            //let annotation = Annotoation(coordinate: location.coordinate, title: place.name, subtitle: place.administrativeArea)
            //
            //self?.mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            
            self?.mapView.setRegion(region, animated: true)
        }
        
        //dismiss the search controller:
        //dismiss keyboard: self.view.endEditing(true)
        navigationItem.searchController?.isActive = false
        
    }
}

extension AddOrchardLocationAndImageViewController: MKMapViewDelegate{
    //how to draw the line
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        
        renderer.lineWidth = 5
        renderer.strokeColor = .orange
        
        return renderer
    }
}

extension AddOrchardLocationAndImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info [.originalImage] as? UIImage{
            orchardImage.image = image
            orchardBackgroundImage = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

