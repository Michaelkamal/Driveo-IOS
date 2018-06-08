//
//  OrdersModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol OrdersModelProtocol {
    
    
    func getOrders(forType type :OrderType, withToken token:String)
    
}
