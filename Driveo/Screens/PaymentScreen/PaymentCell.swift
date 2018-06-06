//
//  PaymentCell.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    
    @IBOutlet weak var paymentImage: UIImageView!
    @IBOutlet weak var paymentSubtitle: UILabel!
    @IBOutlet weak var paymentTitle: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
