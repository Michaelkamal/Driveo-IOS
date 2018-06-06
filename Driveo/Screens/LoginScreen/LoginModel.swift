//
//  LoginModel.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class LoginModel : LoginModelProtocol{
    
    var lp:LoginPresenterProtocol
    
    init(withPresenter p:LoginPresenterProtocol) {
        lp=p
    }
    
    func sendRequest(withParameters params:Dictionary<String,Any>){
        let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
        
//        let defaults = UserDefaults.standard
//        var header = defaults.object(forKey: "token")
//        if header != nil {
//            var headers = header as! HTTPHeaders
//            networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "auth/login", andParameters: params, onSuccess: onSuccess, headers: headers)
//        }
        networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "auth/login", andParameters: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func onSuccess(_ response:Any) -> Void{
        print(response)
        let user = User(email: "", phone: "", password: "")
        let dict = response as! Dictionary<String,Any>
        let defaults = UserDefaults.standard
        let token = dict["auth_token"] as! String
        print(token)
        if token != nil {
            defaults.set(token, forKey :"auth_token")
            defaults.synchronize()
            lp.loginSuccess(user: user, token: token)
        }
        else{
            lp.loginFailure(message: "Wrong email or password")
        }
        
    }
    func onFailure(_ networkError:ErrorType) -> Void{
        lp.loginFailure(message: "Wrong email or password")
    }
    
    
}

