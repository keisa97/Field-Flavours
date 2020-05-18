//
//  LandMark.swift
//  Lec14Location
//
//  Created by shahar keisar on 26/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


struct LandMarks {
    static func load() ->[LandMark]{
        guard let url = Bundle.main.url(forResource: "camp_il", withExtension: "json") else{
            return[]}
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let landMarks = try decoder.decode([LandMark].self, from: data)
            return landMarks
        }catch let err{
            print(err)
        }
        return[]
    }
}

struct LandMark: Codable {
    let address: String
    let id: Int
    let illumination: String
    let name: String
    let powerOutlet:String
    let productURL : String
    let region: String
    let shortDescription:String
    let showers: String
    let specialActivity:String
    let staffRooms: String
    let trailerPark:String
    let url : String
    let vendorID : Int
    let vendorName: String
    let WC: String
    let x: Double
    let y: Double
    
}

//convinience
extension LandMark{
    //coordinate2d(lat long)
    var coodrinate: CLLocationCoordinate2D{
        return .init(latitude: y, longitude: x)
    }
    //location is more than just coordinates: Speed, Altitude, Bearing, distance
    var location: CLLocation{
        return .init(latitude: y, longitude: x)
    }
    
    // to iterate over an enum:
    enum Types: String, CaseIterable{
        case campSchool = "מרכז שדה"
        case nationalPark = "גן לאומי"
        case han = "חאן"
        case nightCamp = "חניון לילה"
        case other = "אחר"
        
        var color: UIColor{
            switch self {
            case .campSchool:
                return .orange
            case .han:
                return .brown
            case .nationalPark:
                return .systemIndigo
            case .nightCamp:
                return .black
            default:
                return .red
            }
        }
    }
    
    //place type: if place.name contains "מרכז שדה " return .campshcool
    var type: Types{
        
        for t in Types.allCases{
            if name.contains(t.rawValue){
                return t
            }
        }
        return .other
    }
}

