//
//  OrdersPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol OrdersPresenterProtocol {
    
    func requestOrders(ofType typeOrder: OrderType)
    
    func onRequestSuccess(withOrders orders:[String:[OrderMock]])
    
    func onRequestFailure(failure :String)
}
