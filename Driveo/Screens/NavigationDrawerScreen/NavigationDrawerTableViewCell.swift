//
//  NavigationDrawerTableViewCell.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class NavigationDrawerTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var moreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
