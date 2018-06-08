//
//  OrdersModel.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class OrderModel : OrdersModelProtocol{
    
    var presenter:OrdersPresenterProtocol
    
    
    init(withPresenter p:OrdersPresenterProtocol) {
        presenter = p
    }
    
    func onRequestSuccess(date:Any)->Void{
        
    }
    
    func onRequestFailure(error:ErrorType)->Void{
        
    }
    
    func getOrders(forType type: OrderType, withToken token: String) {
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        
        networkObject.processPostReq(withBaseUrl: ApiBaseUrl.testmockAoi, andUrlSuffix: type.rawValue, andParameters: ["type":type.rawValue], onSuccess: onRequestSuccess, onFailure: onRequestFailure, headers: ["Authorization":token])
        
      
        
    }
    

}
