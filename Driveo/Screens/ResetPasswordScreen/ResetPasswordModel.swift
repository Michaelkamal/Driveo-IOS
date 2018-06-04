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
        networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "auth/login", andParameters: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func onSuccess(_ response: Any) {
        let dict = response as! Dictionary<String,Any>
        let message = dict["message"] as! String
        if message.contains("done"){
            let defaults = UserDefaults.standard
            let token = dict["reset_token"] as! String
            defaults.set(token, forKey :"reset_token")
            defaults.synchronize()
        }
        rPP.resetSuccess(message:message)
    }
    
    func onFailure(_ networkError: ErrorType) {
        rPP.resetFailure(message: "failed")
    }
    
    
}
