//
//  NextButtonView.swift
//  Driveo
//
//  Created by Admin on 6/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class NextButtonView: UIView {

    @IBOutlet weak var nextButton: RoundedButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public var nextFunc : (()->Void)?
    
    public func registerEditFunction(){
        nextButton.addTarget(self, action:#selector(didTapOnNextButton), for: UIControlEvents.touchUpInside)
    }
    @objc func didTapOnNextButton()
    {
        becomeFirstResponder()
        nextFunc?()
    }

}
