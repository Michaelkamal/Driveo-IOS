//
//  SignupModel.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation


class SignupModel : SignupModelProtocol{
    func onRegisterFailure(data: Any) {
            }
    
   
    

    var presenter:SignupPresenterProtocol
    
    init(presenter :SignupPresenterProtocol) {
        self.presenter = presenter
    }
    
    func registerNewUser(user: User) {
        let networkobject = NetworkDAL.sharedInstance()
        networkobject.processPostReq(withBaseUrl: ApiBaseUrl.mainApi,andUrlSuffix: "signup",andParameters: user.getUserDataInDictionary(),onSuccess: onRegisterSucsess,onFailure: onRegisterFailure)
    }
    
    
    func onRegisterSucsess(data: Any) {
        let response = data as! [String:Any]
        if response["message"] as! String == "Account created successfully" {
            presenter.goToVerifyScreen()
            let defaults = UserDefaults.standard
            let token = response["auth_token"] as! String
            defaults.set(token, forKey :"auth_token")
            defaults.synchronize()
        }else{
            
        
    }
    
}
}
