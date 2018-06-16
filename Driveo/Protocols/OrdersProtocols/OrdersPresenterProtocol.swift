//
//  OrdersPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol OrdersPresenterProtocol {
    
    func requestOrders(ofType typeOrder: OrderType, page:String)
    
    func onRequestSuccess(withOrders orders:RequestOrdersResult)
    
    func onRequestFailure(failure :String)
}
