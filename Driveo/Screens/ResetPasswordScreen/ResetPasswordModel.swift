//
//  ResetPasswordModel.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class ResetPasswordModel: ResetPasswordModelProtocol {
    var rPP : ResetPasswordPresenterProtocol
    
    init(withPresenter p:ResetPasswordPresenterProtocol) {
        rPP=p
    }
    func sendRequest(withParameters params: Dictionary<String, Any>) {
        let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
        let defaults = UserDefaults.standard
        var token = defaults.object(forKey: "reset_token") as! String
        if token != nil{
            networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "reset_password/?hash="+token, andParameters: params, onSuccess: onSuccess, onFailure: onFailure)
            let defaults = UserDefaults.standard
            defaults.set(nil, forKey: "reset_token")
            defaults.synchronize()
        }
    }
    
    func onSuccess(_ response: Any) {
        let dict = response as! Dictionary<String,Any>
        let message = dict["message"] as! String
        rPP.resetSuccess(message:message)
    }
    
    func onFailure(_ networkError: ErrorType) {
        rPP.resetFailure(message: "failed")
    }
    
    
}
