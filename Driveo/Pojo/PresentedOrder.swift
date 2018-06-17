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
    var cost:String?
    var description:String?
    var dest_latitude:Double?
    var dest_longitude:Double?
    var dropoff_location:String?
    var images:[OrderImages]?
    var order_id:Int?
    var payment_method:String?
    var pickup_location:String?
    var src_latitude:Double?
    var src_longitude:Double?
    var status:String?
    var time:String?
    var title:String?
    var weight:Int?
}
class OrderImages: Decodable {
    var url:String?
}
