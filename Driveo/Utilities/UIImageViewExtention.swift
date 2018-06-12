//
//  UIImageViewExtention.swift
//  Driveo
//
//  Created by Admin on 6/11/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

extension UIImageView {

    @IBInspectable
    public var asCircle:Bool {
        set {
            if (newValue) {
                layer.cornerRadius = self.frame.height/2
                clipsToBounds = true;
                }
    }
        get{
            return asCircle
        }
    }
    
}
extension UIView {
    
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
    }
}
