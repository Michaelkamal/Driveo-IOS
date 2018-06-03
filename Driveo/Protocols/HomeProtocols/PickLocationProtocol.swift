//
//  HomeViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
protocol PickLocationProtocol:GenericProtocol {
    var isCurrentScreenSourcePickUp:Bool{get}
    func placeMarker(onLocation location:CLLocation,withTitle title:String,andImage image:UIImage? ) ->Void
    func clearSearchText()->Void
    func displaySelectedCarrier(withLogo logo:UIImage)->Void
    func renderPlaces(placesArray arr:[PlaceDPItem])
    func dismissPlacesSearch()
    
}
