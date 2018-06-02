//
//  DropDownPlacesItem.swift
//  Map
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DropDownPlacesItem: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func reload(item: PlaceDPItem) {
        placeLabel.text = item.place
        cityLabel.text = item.city
        
    }
    
}
