//
//  CarrierDPItem.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
public struct PlaceDPItem {
    
    public var place: String?
    public var city: String?
    public var id:String?
    public init(place: String?, city: String?,id:String?) {
        self.place = place
        self.city = city
        self.id=id
    }
}

