//
//  LandMarkAnnotation.swift
//  Lec14Location
//
//  Created by shahar keisar on 26/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation

class LandMarkAnnotation: Annotoation {
    let landMark: LandMark
    
    init(landMark: LandMark){
        self.landMark = landMark
        
        super.init(coordinate: landMark.coodrinate, title: landMark.name, subtitle: landMark.vendorName)
    }
}
