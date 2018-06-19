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
    var cost:Float?
    var description:String?
    var dest_latitude:Float?
    var dest_longitude:Float?
    var dropoff_location:String?
    //var images:[OrderImages]?
    var order_id:Int?
    var payment_method:String?
    var pickup_location:String?
    var src_latitude:Float?
    var src_longitude:Float?
    var status:String?
    var time:String?
    var title:String?
    var weight:Float?
}
class OrderImages: Decodable {
    var url:String?
}
