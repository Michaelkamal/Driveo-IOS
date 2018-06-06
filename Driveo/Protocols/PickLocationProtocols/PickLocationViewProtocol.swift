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
protocol PickLocationViewProtocol:GenericProtocol {
    var isCurrentScreenSourcePickUp:Bool{get}
    func placeMarker(onLocation location:CLLocation,withTitle title:String,andImage image:UIImage? ) ->Void
    func clearSearchText()->Void
    func updateCarrierArray(withCarriers carriers:[Provider])->Void
    func displaySelectedCarrier(withLogoUrl url:String)->Void
    func renderPlaces(placesArray arr:[PlaceDPItem])
    func dismissPlacesSearch()
    
}
