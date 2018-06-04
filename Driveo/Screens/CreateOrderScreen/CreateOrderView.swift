//
//  CreateOrderView.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class CreateOrderView: UIView {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public var editFunc : (()->Void)?
    
    public func registerEditFunction(){
    editButton.addTarget(self, action:#selector(didTapOnEditButton), for: UIControlEvents.touchUpInside)
    }
    @objc func didTapOnEditButton()
    {
        becomeFirstResponder()
        editFunc?()
    }
}
