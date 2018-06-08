//
//  OrdersModel.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class OrderModel : OrdersModelProtocol{
    
    
    func getOrders(forType type: OrderType, withToken token: String) {
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        
        networkObject.processPostReq(withBaseUrl: <#T##ApiBaseUrl#>, andUrlSuffix: <#T##String#>, andParameters: ["type":type.rawValue], onSuccess: <#T##(Any) -> Void#>, onFailure: <#T##(ErrorType) -> Void#>, headers: ["Authorization":token])
        
        
        
    }
    

}
