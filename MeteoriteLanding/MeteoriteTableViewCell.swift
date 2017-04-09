//
//  MeteoriteTableViewCell.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

class MeteoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    private let customSelectedBackgroundView = UIView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customSelectedBackgroundView.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 54.0/255.0, blue: 61.0/255.0, alpha: 0.5)
        
        selectedBackgroundView = customSelectedBackgroundView
    }
    
}
