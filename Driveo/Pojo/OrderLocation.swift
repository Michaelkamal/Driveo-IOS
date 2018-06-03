//
//  SelectedPlace.swift
//  Map
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation
enum LocationType:String{
    case source
    case destination
}
struct OrderLocation {
    var locationType : LocationType
    var address : String?
    var coordinates: CLLocation?
    
    init(locationType type:LocationType,withCoordinates coordinates:CLLocation?=nil,andAddress address:String?=nil) {
        self.locationType=type
        self.coordinates=coordinates
        self.address=address
    }
    func isComplete()->Bool{
    if address != nil , coordinates != nil
        {
            return true
        }
        return false
    }
}
