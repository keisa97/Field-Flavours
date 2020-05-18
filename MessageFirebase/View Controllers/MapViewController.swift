//
//  MapViewController.swift
//  Lec14Location
//
//  Created by shahar keisar on 22/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    var orchards = [OrchardModel]()
    
    
    //    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
    //        if let mapView = self.view.viewWithTag(999) as? MKMapView { // set tag in IB
    //                // remove current annons except user location
    //                let annotationsToRemove = mapView.annotations.filter
    //                    { $0 !== mapView.userLocation }
    //                mapView.removeAnnotations( annotationsToRemove )
    //
    //                // add new annon
    //                let location = sender.locationInView(mapView)
    //                let coordinate = mapView.convertPoint(location,
    //                                                      toCoordinateFromView: mapView)
    //                let annotation = MKPointAnnotation()
    //                annotation.coordinate = coordinate
    //                mapView.addAnnotation(annotation)
    //          }
    //
    //
    //        if sender.state != UIGestureRecognizer.State.began { return }
    //        let touchLocation = sender.location(in: mapView)
    //        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
    //        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    //    }
    @IBAction func userPinLocation(_ sender: UITapGestureRecognizer) {
        //        if (userPinLocation.state != UIGestureRecognizerStateBegan){
        //            return
        //        }
        //
        //
        //        var touchPoint : CGPoint = [userPinLocation, locationInView : self.mapView]
        //        var location : CLLocationCoordinate2D =
        //            [self.mapView convertPoint : touchPoint toCoordinateFromView:self.mapView]
        //
        //        print("Location found from Map: %f %f",location.latitude,location.longitude)
        
        //       if sender.state != UIGestureRecognizer.State.began { return }
        //       let touchLocation = sender.location(in: mapView)
        //       let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        //       print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    }
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
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var ODC = OrchardDataSource()
//        ODC.loadOrchards {[weak self] (arrGotten) in
//            self?.orchads = arrGotten
//            self?.mapView.delegate = self
//
//            self?.mapView.reloadInputViews()
        
            OrchardModel.ref.observe(.childAdded){[weak self] (snapshot)in
            guard let dict = snapshot.value as? [String:Any],
                let orchard = OrchardModel(dict: dict) else{ return }
            
            //add the room to the array:
            self?.orchards.append(orchard)
            guard let strongSelf = self else{return}
            
        }
        print("view did load" , orchards.count)
        
        
        
        
        
        
        
        //add annotations
        //        //map landmark -> annotation:
        //        let annotations = landMarks.map { (landMark) -> LandMarkAnnotation in
        //            return LandMarkAnnotation(landMark: landMark)
        //        }
        //        //short and consice:
        //        let allAnnotations = landMarks.map(LandMarkAnnotation.init)
        //        mapView.addAnnotations(allAnnotations)
        // simple way add annotations.
        //        for landMark in landMarks{
        //
        //            let annotation = LandMarkAnnotation(landMark: landMark)
        //
        //            mapView.addAnnotation(annotation)
        //        }
        
        //add annotation
        
        let lm =  LocationManager.shared
        
        //we have permission?
        if lm.hasLocationPermission{
            mapView.showsUserLocation = true
        }
        mapView.delegate = self
        
        
        
    }
    
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        
        
    }
    
    
    
    func zoomIn(coord: CLLocationCoordinate2D){
        
        
        //region(coord +
        let region = MKCoordinateRegion(center: coord, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotation(coord: CLLocationCoordinate2D){
        let annotation = Annotoation(coordinate: coord, title: "hof dor", subtitle: "some place")
        //        annotation.coordinate = coord
        //        annotation.title = "Hof Dor"
        //        annotation.subtitle = "the beach"
        
        mapView.addAnnotation(annotation)
    }
    
    
}
extension MapViewController : MKMapViewDelegate{
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
//        var ODC = OrchardDataSource()
//        ODC.loadOrchards {[weak self] (arrGotten) in
//            self?.orchads = arrGotten
//            guard let strongSelf = self else{return}
        
        
            OrchardModel.ref.observe(.childAdded){[weak self] (snapshot)in
            guard let dict = snapshot.value as? [String:Any],
                let orchard = OrchardModel(dict: dict) else{ return }
            
            //add the room to the array:
            self?.orchards.append(orchard)
            guard let strongSelf = self else{return}
        
            mapView.addAnnotations(strongSelf.orchards.map(OrhadsAnnotation.init))
            let lm =  LocationManager.shared
            
            //we have permission?
            if lm.hasLocationPermission{
                mapView.showsUserLocation = true
            }
            //mapView.delegate = self
            
            //strongSelf.zoomIn(coord: strongSelf.orchads[0].coodrinate)
            //self?.mapView.delegate = self
            
            //self?.mapView.reloadInputViews()
            
            
        }
        print("view did load" , orchards.count)
        
        
        
        
        
        //self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //check that it's our annotation: (we don't want to change apple's annottions)
        guard let annotation = annotation as? OrhadsAnnotation else {
            print("first of annotation")
            return nil
        }
        
        let id = "Orchard"
        var v = mapView.dequeueReusableAnnotationView(withIdentifier: id) as?  MKPinAnnotationView
        if v == nil{
            v = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            //v?.pinTintColor = annotation.landMark.type.color
            v?.canShowCallout = true
            v?.rightCalloutAccessoryView = UIButton(type: .infoLight)
            v?.calloutOffset = CGPoint(x: 5, y: 5)
            print("create annotation")
        }else{
            //annotation already exist:
            v?.annotation = annotation
            //v?.pinTintColor = annotation.landMark.type.color
            print("annotation already exist")
            
        }
        
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Orchard")
        //view.pinTintColor = annotation.landMark.type.color
        
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .infoLight)
        view.calloutOffset = CGPoint(x: 5, y: 5)
        print("check - let view = MKPinAnnotationView")
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? OrhadsAnnotation else {return}
        
        //let landMark = annotation.landMark
        let orchard = annotation.orchard
        print("mapView" ,orchard)
        
        
        
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            detailsVC.orchard = orchard
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
