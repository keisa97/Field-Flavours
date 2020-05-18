//
//  RoundImageView.swift
//  MessageFirebase
//
//  Created by shahar keisar on 03/04/2020.
//  Copyright © 2020 shahar keisar. All rights reserved.
//

import UIKit
class RoundImageView: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
