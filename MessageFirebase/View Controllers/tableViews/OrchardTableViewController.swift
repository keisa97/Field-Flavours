//
//  OrchardTableViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 28/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth

class OrchardTableViewController: UITableViewController {

    var orchards = [OrchardModel]()
    
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
        OrchardModel.ref.queryOrdered(byChild: "orchardOwnerID").queryEqual(toValue: user.uid).observe(.childAdded){[weak self] (snapshot)in
            guard let dict = snapshot.value as? [String:Any],
                let orchard = OrchardModel(dict: dict) else{ return }
            
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
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
