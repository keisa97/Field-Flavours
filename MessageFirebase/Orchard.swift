////
////  Orchard.swift
////  MessageFirebase
////
////  Created by shahar keisar on 28/03/2020.
////  Copyright © 2020 shahar keisar. All rights reserved.
////
//
//import Foundation
//import Firebase
//import UIKit
//import CoreLocation
//
//
//
//
//work with firestore
//struct Orchard{
//    var orchadName: String
//    var fruitsAvailable: String
//    var longitude: Double
//    var latitude : Double
//
//}
//
//class OrchardDataSource {
//    //callback
//
//
//
//    func loadOrchards(callback: @escaping ([Orchard])-> Void){
//        var orchads :[Orchard] = []
//             var ref = Firestore.firestore()
//        var orchadsData = ref.collection("orchads")
//                           orchadsData.getDocuments { (snapshot, error) in
//                               if error == nil && snapshot != nil {
//                                   for document in snapshot!.documents{
//                                       let documentData = document.data()
//                                       let orchadName = documentData["orchad_name"] as? String ?? "error"
//                                       let fruitsAviliable = documentData["fruits_available"] as? String ?? "error"
//                                    let latitude = documentData["lat"] as? Double ?? 1.1
//                                    let longitude = documentData["long"] as? Double ?? 1.1
//                                       orchads.append(Orchard(orchadName: orchadName,
//                                                              fruitsAvailable: fruitsAviliable,
//                                                              longitude : longitude, latitude: latitude))
//                                        print("from load orchards" ,orchadName)
//
//                                   }
//                                callback(orchads)
//                               }
//                          }
//
//
//
//
//    }
//
//    func addOrchad(orchard: Orchard){
//        guard let user = Auth.auth().currentUser else {
//            print("no user is connected")
//            return
//        }
//
//        var db = Firestore.firestore()
//        print(orchard.orchadName, "print in func addOrchad orchadName")
//        //var documentName =
//
//        //if (checkForDuplicateOrchads(orchadName: orchad.orchadName)) {
//
//
//
//            db.collection("orchads").addDocument(data: [
//                "orchad_owner" : user.uid,
//                "orchad_name": orchard.orchadName,
//                "fruits_available": orchard.fruitsAvailable,
//                "lat" : orchard.latitude,
//                "long" : orchard.longitude,
//
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//            //}
//    }
//
//    func checkForDuplicateOrchads(orchadName: String) -> Bool{
//        var ref = Firestore.firestore()
//        var orchadsData = ref.collection("orchads").document(orchadName)
//        if (orchadsData != nil ){
//            print("orchad already exist, TODO: show error to user")
//            return false
//        }
//           return true
//
//
//
//    }
//
//    func needToEditUpdateOrchad(orchad: Orchard){
//        guard let user = Auth.auth().currentUser else {
//            print("no user is connected")
//            return
//        }
//
//        var db = Firestore.firestore()
//        print(orchad.orchadName, "print in func addOrchad orchadName")
//        //var documentName =
//
//        if (checkForDuplicateOrchads(orchadName: orchad.orchadName)) {
//
//
//
//            db.collection("orchads").document(orchad.orchadName).setData( [
//                "orchad_owner" : user.uid,
//                "orchad_name": orchad.orchadName,
//                "fruits_available": orchad.fruitsAvailable,
//                "location": "Tal-Shahar"
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        }
//    }
//}
//
//extension Orchard{
//    //coordinate2d(lat long)
//    var coodrinate: CLLocationCoordinate2D{
//        return .init(latitude: latitude, longitude: longitude)
//    }
//    //location is more than just coordinates: Speed, Altitude, Bearing, distance
//    var location: CLLocation{
//        return .init(latitude: latitude, longitude: longitude)
//    }
//}
//
//  //ref.collection("users").whereField("first_name", in: <#T##[Any]#>)
//
//         // Get user value
//         //let value = snapshot.value as? NSDictionary
//         //let username = value?["first_name"] as? String ?? ""
////         let user = Orchard(email: username)
////           print(username, ("check Debug"))
////
////         // ...
////         }) { (error) in
////           print(error.localizedDescription)
