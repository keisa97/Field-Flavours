//
//  OrchardModel.swift
//  MessageFirebase
//
//  Created by shahar keisar on 12/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import CoreLocation

class OrchardModel : FirebaseModel{
    
    var orchardOwnerID : String
    var orchadName: String
    var fruitsAvailable: String
    var orchardDescription: String
    var orchardImageBackgroundImageURL : String?
    var latitude : Double
    var longitude: Double
    let contactNumber: String
    let createdDate: Date
    let snapshotKey: String
    
    
    //for write
    var dict: [String : Any]{
        var dict = ["orchardOwnerID": orchardOwnerID,
                    "orchadName":orchadName,
                    "fruitsAvailable":fruitsAvailable,
                    "orchardDescription":orchardDescription ,
                    "latitude" : latitude,
                    "longitude" : longitude,
                    "contactNumber" : contactNumber,
                    "snapshotKey" : (UUID().uuidString),
                    "createdDate":Self.formatter.string(from: createdDate)] as [String : Any]
    
        if let imageURL = self.orchardImageBackgroundImageURL{
            dict["orchardImageBackgroundImageURL"] = imageURL
        }
        
        return dict
    }
    
    init(orchardOwnerID: String, orchadName:String, fruitsAvailable: String,
         orchardDescription: String, orchardBackgroundImageURL: String? = nil ,
         latitude : Double, longitude: Double, contactNumber: String,
         imageURL:String? = nil) {
        self.orchardOwnerID = Auth.auth().currentUser?.uid as! String
        self.orchadName = orchadName
        self.fruitsAvailable = fruitsAvailable
        self.orchardDescription = orchardDescription
        self.latitude = latitude
        self.longitude = longitude
        self.contactNumber = contactNumber
        self.snapshotKey = .init()
        self.createdDate = .init()
        self.orchardImageBackgroundImageURL = orchardBackgroundImageURL
    }
    
    //for read
    required init?(dict: [String:Any]){
        guard let orchardOwnerID = dict["orchardOwnerID"] as? String,
            let orchadName = dict["orchadName"] as? String,
            let fruitsAvailable = dict["fruitsAvailable"] as? String,
            let orchardDescription = dict["orchardDescription"] as? String,
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double,
            let contactNumber = dict["contactNumber"] as? String,
            let snapshotKey = dict["snapshotKey"] as? String,
            let dateString = dict["createdDate"] as? String,
            let createdDate = Self.formatter.date(from: dateString)
            else {
                print(#function)
                print("Dict problem")
                return nil} // if json is invalid -> return nil
                print("Dict problem")
    
    
        self.orchardOwnerID = orchardOwnerID
        self.orchadName = orchadName
        self.fruitsAvailable = fruitsAvailable
        self.orchardDescription = orchardDescription
        self.latitude = latitude
        self.longitude = longitude
        self.contactNumber = contactNumber
        self.snapshotKey = snapshotKey
        self.createdDate = createdDate

        //imageURL is optional (so it's not guarded) (nice to have)
        self.orchardImageBackgroundImageURL = dict["orchardImageBackgroundImageURL"] as? String
    }
    
    
}


extension OrchardModel{
    
    //coordinate2d(lat long)
    var coodrinate: CLLocationCoordinate2D{
        return .init(latitude: latitude, longitude: longitude)
    }
    //location is more than just coordinates: Speed, Altitude, Bearing, distance
    var location: CLLocation{
        return .init(latitude: latitude, longitude: longitude)
    }
    
    
    static var ref: DatabaseReference{
        return Database.database().reference().child("Orchards")

    }
    
    //storage of images:
    var imageRef: StorageReference{//images are saved under roomID
        return Storage.storage().reference().child("Orchards").child(orchardOwnerID).child(orchardOwnerID + orchadName + ".jpg")
    }
    
    func save(callback: @escaping (Error?, Bool)-> Void){
        //save to db:
        //can use also Self.ref
        var fileName = self.orchardOwnerID + self.orchadName.replacingOccurrences(of: " ", with: "")
        print(self.snapshotKey)
        OrchardModel.ref.child(fileName).setValue(dict) { [weak self] (err, dbRef) in
            if let err = err{
                callback(err, false)
                return
            }
            callback(nil , true)//tell the listener
        }
    }
    
    //save the image:
    //1) save the image
    //2) only after the imaged uploaded -> save the room
    func save(image: UIImage, callback : @escaping (Error?, Bool)-> Void){
        //convert image to data:
        guard let data = image.jpegData(compressionQuality: 0.1) else{
            callback(nil, false)//cant save  image
            return
        }
        //upload
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            if let err = err{
                callback(err, false)
                return
            }
            //the image is saved:
            //now save the data:
            
            //db:
            var imageName = self.orchardOwnerID + self.orchadName.replacingOccurrences(of: " ", with: "")
            self.orchardImageBackgroundImageURL = imageName + ".jpg"// if.jpg
            
            self.save(callback: callback)
    //            ChatRoom.ref.child(self.id).setValue(self.dict) { (err, dbRef) in
    //                if let err = err{
    //                    callback(err, false)
    //                    return
    //                }
    //                callback(nil , true)
    //            }
            }
            
        }
    
    func update(snapshotKey:String, callback: @escaping (Error?, Bool)-> Void){
        //save to db:
        //can use also Self.ref
        var fileName = self.orchardOwnerID + self.orchadName.replacingOccurrences(of: " ", with: "")
        print(self.snapshotKey)
        OrchardModel.ref.child(fileName).updateChildValues(dict) { [weak self] (err, dbRef) in
            if let err = err{
                callback(err, false)
                return
            }
            callback(nil , true)//tell the listener
        }
    }
    func update(image: UIImage,snapshotKey:String, callback : @escaping (Error?, Bool)-> Void){
        //convert image to data:
        guard let data = image.jpegData(compressionQuality: 0.1) else{
            callback(nil, false)//cant save  image
            return
        }
        //upload
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            if let err = err{
                callback(err, false)
                return
            }
            //the image is saved:
            //now save the data:
            
            //db:
            var imageName = self.orchardOwnerID + self.orchadName.replacingOccurrences(of: " ", with: "")
            self.orchardImageBackgroundImageURL = imageName + ".jpg"// if.jpg
            
            self.update(snapshotKey: snapshotKey, callback: callback)
    //            ChatRoom.ref.child(self.id).setValue(self.dict) { (err, dbRef) in
    //                if let err = err{
    //                    callback(err, false)
    //                    return
    //                }
    //                callback(nil , true)
    //            }
            }
            
        }

    
    
    func deleteUserCell(){

    }
}


