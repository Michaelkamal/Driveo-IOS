//
//  CarrierDPItem.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

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

public struct CarrierDPItem {
    public var carrierName: String?
    public var carrierLogo: UIImage?
    public var rating: String?
    
    public init(CarrierName name:String?,andRating rating: String?,image: UIImage?) {
        self.carrierName=name
        self.rating = rating
        self.carrierLogo = image
    }
    
    public init(rating: String) {
        self.rating = rating
    }
}
