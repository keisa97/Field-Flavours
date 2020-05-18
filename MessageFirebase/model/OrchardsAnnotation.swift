//
//  OrchardsAnnotation.swift
//  MessageFirebase
//
//  Created by shahar keisar on 07/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
class OrhadsAnnotation: Annotoation {
    let orchard: OrchardModel
    
    init(orchard: OrchardModel){
        self.orchard = orchard
    
        super.init(coordinate: orchard.coodrinate, title:  orchard.orchadName)
    }
}
