//
//  LocationManager.swift
//  MessageFirebase
//
//  Created by shahar keisar on 22/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager : NSObject{
    //singleton + NSObject
    static let shared = LocationManager()
    //properties:
    let ourLocationManager = CLLocationManager()
    //read only from outside this class
    private(set) var isMonitoringLocation = false
    //empty array of user locations
    private(set) var steps:[CLLocation] = []
    
    private override init() {
        super.init()
        //be the delegate
        ourLocationManager.delegate = self
        
        //how accurate should location requests be:
        ourLocationManager.activityType = .fitness
        ourLocationManager.distanceFilter = 100 // only notify if the user location
        
        ourLocationManager.desiredAccuracy = kCLLocationAccuracyBest //GPS, satalite
    }
    
//coputed property
    func start(){
        isMonitoringLocation = true
        //clear the array of steps:
        steps.removeAll()
        
        if hasLocationPermission{
            ourLocationManager.stopUpdatingLocation()//callback!
        }
    }
    
    func stop(){
        isMonitoringLocation = false
        ourLocationManager.stopUpdatingLocation()
        
    }
    
    var hasLocationPermission: Bool{
        let status = CLLocationManager.authorizationStatus()
        
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    //the last known user location:
    var lastKnownUserLocation: CLLocation?{
        return ourLocationManager.location
    }
}
//if need to get location from user
extension LocationManager : CLLocationManagerDelegate{
    //ask permission to see user location
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //array += locations
     steps += locations
}

//ask permission to see user location
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
        print("we have permission")
     
    case .denied:
        print("no permission")
        break
        
    case .notDetermined:
        print("didn't ask yet")//ask for permission
        ourLocationManager.requestWhenInUseAuthorization()
    
    default:
        break
    }
}
}



