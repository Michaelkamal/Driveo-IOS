//
//  OrdersModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol OrdersModelProtocol {
    
    
    func getOrders(forPage page :String, withToken token:String, forType type:OrderType)
    
}
