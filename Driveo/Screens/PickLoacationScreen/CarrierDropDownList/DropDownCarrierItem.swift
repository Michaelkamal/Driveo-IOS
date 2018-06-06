//
//  DropDownCarrierItem.swift
//  Map
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DropDownCarrierItem: UITableViewCell {
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var carrierLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func reload(item: Provider) {
        ratingLabel.text = item.rating
        carrierLogo.sd_setImage(with: URL(string:ApiBaseUrl.mainApi.rawValue+item.image!.url!), completed: nil) 
        
    }
}
