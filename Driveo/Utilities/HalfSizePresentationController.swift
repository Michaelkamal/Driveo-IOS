//
//  HalfSizePresentationController.swift
//  Driveo
//
//  Created by Admin on 6/11/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class HalfSizePresentationController : UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            
            return CGRect(x: 0, y: theView.bounds.height-368, width: theView.bounds.width, height: 368)
        }
        
    }
}
