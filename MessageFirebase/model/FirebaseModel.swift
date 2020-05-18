//
//  FirebaseModel.swift
//  MessageFirebase
//
//  Created by shahar keisar on 12/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
protocol FirebaseModel{
    //from Json
    init?(dict: [String: Any])
    //to JSon:
    var dict:[String: Any]{get}
    
}
extension FirebaseModel{
    //property = every instance has it's own formatter
    
    //static property = formatter is shared
    
    //shared formatter
    static var formatter:ISO8601DateFormatter{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, . withFractionalSeconds]
        return formatter
    }
}


