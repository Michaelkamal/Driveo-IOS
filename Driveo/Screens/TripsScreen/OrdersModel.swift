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
    
    func onRequestSuccess(date:Data)->Void{
        
    }
    
    func onRequestFailure(error:ErrorType)->Void{
        
    }
    
    
    
    
    func getOrders(forType type: OrderType, withToken token: String) {
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        var suffixUrl = SuffixUrl.orders.rawValue + "1"
        
        networkObject.processReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: suffixUrl, withParser: { (data) -> [Any] in
            if let response = try? JSONDecoder().decode(RequestOrdersResult.self, from: data.rawData()){
               return [response] as [Any]
            }
            return []
        }, andHeaders: ["Authorization":token], onSuccess: {(responseArray) in
            if let respone = responseArray.first as? RequestOrdersResult {
                print(respone)
                if respone.message == MsgResponse.success.rawValue {
                    self.presenter.onRequestSuccess(withOrders: respone.data)
                }
                self.presenter.onRequestFailure(failure: ErrorType.parse.rawValue)
            }
        }, onFailure: onRequestFailure)
        
        networkObject.processPostReq(withBaseUrl: ApiBaseUrl.testmockAoi, andUrlSuffix: type.rawValue, andParameters: ["type":type.rawValue], onSuccess: onRequestSuccess, onFailure: onRequestFailure, headers: ["Authorization":token])
        
      
        
    }
    

}
