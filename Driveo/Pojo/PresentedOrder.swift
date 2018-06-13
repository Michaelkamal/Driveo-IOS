//
//  PresentedOrder.swift
//  Driveo
//
//  Created by Admin on 6/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

struct PresentedOrder: Decodable {
    
    var title:String?
    var orderId:String?
    var description:String?
    var images:[String]?
    var payementMethod:String?
    var price:String?
    var pickUpAddress:String?
    var pickUplat:String?
    var pickUpLong:String?
    var dropOffAddress:String?
    var dropOffUplat:String?
    var dropOffLong:String?
    var date:String?
    var status:String?
    
}
