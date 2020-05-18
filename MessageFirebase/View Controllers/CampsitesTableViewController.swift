//
//  CampsitesTableViewController.swift
//  Lec14Location
//
//  Created by shahar keisar on 26/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit

class CampsitesTableViewController: UITableViewController {

    var landMarks = LandMarks.load()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //sortResults()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //show the first place
//        if let split = splitViewController, !split.isCollapsed{
//            performSegue(withIdentifier: "details", sender: landMarks[0])
//
//        }
//    }

//    func sortResults(){
//        guard let location = LocaionManager.shared.lastKnownUserLocation else {return}
//        landMarks.sort { (landMark1, landMark2) -> Bool in
//            //areInIncreasingOrder
//            //distance to our location
//            let distance1 = location.distance(from: landMark1.location)
//            let distance2 = location.distance(from: landMark2.location)
//
//            return distance1 < distance2
//        }
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return landMarks.count
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        // Configure the cell...
//        if let cell = cell as? CampTableViewCell{
//            cell.populate(with: landMarks[indexPath.row])
//        }
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //show details
//        performSegue(withIdentifier: "details", sender: landMarks[indexPath.row])
//        
//        
//    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        //what is the dest? navigationController
//        guard let nav = segue.destination as? UINavigationController,
//            let dest = nav.topViewController as? DetailsViewController,
//            let landMark = sender as? LandMark
//            else{
//                return
//        }
//        dest.landMark = landMark
//    }

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
