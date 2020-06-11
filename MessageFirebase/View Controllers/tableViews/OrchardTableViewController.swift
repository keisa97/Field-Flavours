//
//  OrchardTableViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 28/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class OrchardTableViewController: UITableViewController {

    var databaseQuery : DatabaseReference!
    var orchards = [OrchardModel]()
    var snapshotKey: String?
    
    
    @IBOutlet var ourTableView: UITableView!
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            //EULA
            Router.shared.chooseMainViewController()
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = Auth.auth().currentUser else {return}
        
        //if let userID = OrchardModel.ref.child(user.uid)
//        if let userObjects = OrchardModel.ref.{
//            
//        }
        
        //for get only user orchards we use :
        // .queryOrdered(byChild: "orchardOwnerID").queryEqual(toValue: user.uid) to our ref
        
        if (user != nil){
            databaseQuery == OrchardModel.ref.queryOrdered(byChild: "orchardOwnerID")
        }
        
//        guard databaseQuery == OrchardModel.ref.queryOrdered(byChild: "orchardOwnerID")else{
//            return
//        }
        OrchardModel.ref.queryOrdered(byChild: "orchardOwnerID")
            .queryEqual(toValue: user.uid).observe(.childAdded){[weak self] (snapshot)in
            guard let dict = snapshot.value as? [String:Any],
                let orchard = OrchardModel(dict: dict) else{ return }
                
                print("keys: ", snapshot.key)
                self?.snapshotKey = snapshot.key
                print("first table show", self?.databaseQuery,
                      orchard)
                
            //add the room to the array:
            self?.orchards.append(orchard)
            guard let strongSelf = self else{return}
            //tell the table view : (tableview.insertRows)
            let path = IndexPath(row: strongSelf.orchards.count - 1 ?? 0, section: 0)
            self?.tableView.insertRows(at: [path], with: .automatic)
        }
        
        
        
        
        
        

//        var test = OrchardDataSource()
//        test.loadOrchards {[weak self] (arrGotten) in
//            self?.orchads = arrGotten
//            self?.someTable.reloadData()
            
            
            
//        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
//    func deleteOrchard(){
//        guard let user = Auth.auth().currentUser else {return}
//        print(databaseQuery)
//
//
//        //#1try
//
//        databaseQuery.queryEqual(toValue: user.uid).observeSingleEvent(of: .childRemoved){[weak self] (snapshot)in
//                    guard let dict = snapshot.value as? [String:Any],
//                        let orchard = OrchardModel(dict: dict) else{ return }
//            print("delete row show", self?.databaseQuery,
//                                 orchard)
//            guard let strongSelf = self else{return}
//            //tell the table view : (tableview.insertRows)
//            let path = IndexPath(row: indexPath.row ?? 0, section: 0)
//            self?.tableView.deleteRows(at: [path], with: .automatic)
//        }
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return orchards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrchardCell", for: indexPath) as! OrchardTableViewCell

//        // Configure the cell...
//        let row = indexPath.row
//        let orchad = orchads[row]
//
//        cell.nameLabel.text = orchad.orchadName
//        Utilities.styleTextField(cell.nameLabel)
//        cell.cellImageView.clipsToBounds = true
//        cell.availableFruitsLabel.text = orchad.fruitsAvailable
        
        if let cell = cell as? OrchardTableViewCell{
            cell.populate(orchard: orchards[indexPath.row])
        }


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show details
        performSegue(withIdentifier: "details", sender: orchards[indexPath.row])
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //what is the dest? navigationController
        guard let nav = segue.destination as? UINavigationController,
            let dest = nav.topViewController as? DetailsViewController,
            let orchard = sender as? OrchardModel
            else{
                return
        }
        dest.orchard = orchard
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(#function , "first action in delete!")
            // Delete the row from the data source
            //let action = fetc
            guard let user = Auth.auth().currentUser else {return}
            print(databaseQuery)
            
            print(OrchardModel.ref)
            let childRef = orchards[indexPath.row].orchardOwnerID + orchards[indexPath.row].orchadName.replacingOccurrences(of: " ", with: "")
            OrchardModel.ref.child(childRef).removeValue()
            print("indexPath.row", indexPath.row)
            let path = IndexPath(row: indexPath.row, section: 0)
            print("orchards.count" , orchards.count)
            self.orchards.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [path], with: .automatic)
            //#1try
            
            OrchardModel.ref.observe(.childRemoved){[weak self] (snapshot)in
                        guard let dict = snapshot.value as? [String:Any],
                            let orchard = OrchardModel(dict: dict) else{ return }
                print("delete row show", self?.databaseQuery,
                                     orchard)
                

//                if (user != nil){
//                    var fileName = orchard.orchardOwnerID + orchard.orchadName.replacingOccurrences(of: " ", with: "")
//                    //tell the table view : (tableview.insertRows)
//                    let path = IndexPath(row: indexPath.row, section: 0)
//                    OrchardModel.ref.child(fileName).removeValue()
//                    print("indexPath.row", indexPath.row)
//                    self?.orchards.remove(at: indexPath.row)
//                    self?.tableView.deleteRows(at: [path], with: .automatic)
//                    //guard let strongSelf = self else{return}
//                    //[strongSelf].removeObjectAtIndex;: [indexPath.row]
//                    //orchards.remove[indexPath.row]
//                }

                //                let groceryItem = self?.orchards[indexPath.row]
//                groceryItem.self
                
                //mileageDatabase.remove[indexPath.row]
                //self?.tableView.reloadData()
            }

            //#1try
            
            
            
//              // Get user value
//              let value = snapshot.value as? NSDictionary
//              let username = value?["username"] as? String ?? ""
//              let user = User(username: username)
//
//              // ...
//              }) { (error) in
//                print(error.localizedDescription)
//            }
//            (.childRemoved){[weak self] (snapshot)in
//            guard let dict = snapshot.value as? [String:Any],
//                let orchard = OrchardModel(dict: dict) else{ return }
//                self?.orchards.remove(at: indexPath.row)
////                self?.databaseQuery.removeValue { error, _ in
////
////                    print(error)
////                }
//            }
            
            
            //tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
