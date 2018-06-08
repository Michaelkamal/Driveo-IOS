//
//  UIButtonExtension.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    
    @IBInspectable
override  public var  cornerRadius:CGFloat{
        set{
            self.layer.cornerRadius = newValue
        }
        get{
            return self.layer.cornerRadius
        }
    }
}
