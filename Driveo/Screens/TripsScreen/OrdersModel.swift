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
    
    func onRequestFailure(error:ErrorType)->Void{
        presenter.onRequestFailure(failure: "failed")
    }
    
    
    
    
    func getOrders(forPage page :String, withToken token:String, forType type:OrderType){
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        var suffixUrl = ""
        
        if type == OrderType.HistoryOrders{
            suffixUrl = SuffixUrl.historyOrders.rawValue + page
        }else{
            suffixUrl = SuffixUrl.upcomingOrders.rawValue + page
        }
        
        
        
        networkObject.processReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: suffixUrl, withParser: { (data) -> [Any] in
            if let response = try? JSONDecoder().decode(RequestOrdersResult.self, from: data.rawData()){
               return [response] as [Any]
            }
            return []
        }, andHeaders: ["Authorization":token], onSuccess: {(responseArray) in
            if let respone = responseArray.first as? RequestOrdersResult {
                print(respone)
                if respone.message == MsgResponse.success.rawValue {
                    self.presenter.onRequestSuccess(withOrders: respone)
                }else{
                    self.presenter.onRequestFailure(failure: ErrorType.parse.rawValue)
                }
                
            }
        }, onFailure: onRequestFailure)

        
      
        
    }
    

}
