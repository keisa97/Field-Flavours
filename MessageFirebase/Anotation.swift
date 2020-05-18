//
//  Anotation.swift
//  Lec14Location
//
//  Created by shahar keisar on 22/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
import MapKit
//Custom Annotation: (pizza, sport shoe)

class Annotoation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    //var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil){
        self.coordinate = coordinate
        self.title = title
        //self.subtitle = subtitle
        
    }
    
    
}
