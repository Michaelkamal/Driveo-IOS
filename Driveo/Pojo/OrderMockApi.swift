//
//  OrderMockApi.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

enum OrderType :String{

        case HistoryOrders = "getHistoryOrders"
        case UpcomingOrders = "Upcoming"
}

struct OrderMock {
    
    var date:String
    var price:Double
    var from:String
    var to:String
    var payment:String
    
}
