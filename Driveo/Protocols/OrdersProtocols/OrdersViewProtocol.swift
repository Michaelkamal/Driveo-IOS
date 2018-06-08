//
//  OrdersViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol  OrdersViewProtocol {
    
    func onLoadFailure(failure :String)
    func getInfoForTabOf(orderType order: OrderType, useData: @escaping (_ : [String:[OrderMock]]) -> Void)
    func showLoading()
    func dismissLoading()
    
}
