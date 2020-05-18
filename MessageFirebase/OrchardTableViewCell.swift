//
//  OrchardTableViewCell.swift
//  MessageFirebase
//
//  Created by shahar keisar on 28/03/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
import FirebaseUI

class OrchardTableViewCell: UITableViewCell {
    @IBOutlet weak var availableFruitsLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var orchard : OrchardModel?
    
    @IBAction func quickNavigateButton(_ sender: UIButton) {
        guard let orchard = orchard,
            let url = URL(string:    "http://maps.apple.com/?daddr=\(orchard.coodrinate.latitude),\(orchard.coodrinate.longitude)") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func populate(orchard: OrchardModel){
        nameLabel.text = orchard.orchadName
        availableFruitsLabel.text = orchard.fruitsAvailable
        
        
        let ref = orchard.imageRef
        //if we have an image load it
        if let _ = orchard.orchardImageBackgroundImageURL{
            cellImageView.sd_setImage(with: ref)
            
            //placeholder:
            cellImageView.sd_setImage(with: ref, placeholderImage: #imageLiteral(resourceName: "apple tree"))
        }else{
            //could get ref
            cellImageView.image = #imageLiteral(resourceName: "apple tree")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
