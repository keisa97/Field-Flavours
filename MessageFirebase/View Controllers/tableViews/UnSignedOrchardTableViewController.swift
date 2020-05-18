//
//  UnSignedOrchardTableViewController.swift
//  MessageFirebase
//
//  Created by shahar keisar on 01/05/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseAuth

class UnSignedOrchardTableViewController: UITableViewController {

    @IBAction func Logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            //EULA
            Router.shared.chooseMainViewController()
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    var orchards = [OrchardModel]()
    
    @IBOutlet var OurTableView: UITableView!
    
    func sortResults(){
        guard let location = LocationManager.shared.lastKnownUserLocation else {return}
        orchards.sort { (orchard1, orchard2) -> Bool in
            //areInIncreasingOrder
            //distance to our location
            let distance1 = location.distance(from: orchard1.location)
            let distance2 = location.distance(from: orchard2.location)
            
            return distance1 < distance2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortResults()
        
//        if let split = splitViewController, !split.isCollapsed{
//            performSegue(withIdentifier: "details", sender: orchads[0])
//
//        }
        

//        var test = OrchardDataSource()
//        test.loadOrchards {[weak self] (arrGotten) in
//            self?.orchards = arrGotten
//            self?.OurTableView.reloadData()
//        }
//        guard let anyString : String else {
//            return
//        }
        
        OrchardModel.ref.observe(.childAdded){[weak self] (snapshot)in
            guard let dict = snapshot.value as? [String:Any],
                let orchard = OrchardModel(dict: dict) else{ return }
            
            //add the room to the array:
            self?.orchards.append(orchard)
            guard let strongSelf = self else{return}
            //tell the table view : (tableview.insertRows)
            let path = IndexPath(row: strongSelf.orchards.count - 1 ?? 0, section: 0)
            self?.tableView.insertRows(at: [path], with: .automatic)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

        //show the first place
        if let split = splitViewController, !split.isCollapsed{
            performSegue(withIdentifier: "details", sender: orchards[0])

        }
        
        
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
//        let orchad = orchards[row]
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
