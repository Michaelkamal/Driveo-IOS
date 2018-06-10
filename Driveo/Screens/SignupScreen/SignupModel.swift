//
//  SignupModel.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation


class SignupModel : SignupModelProtocol{

    var presenter:SignupPresenterProtocol
    
    init(presenter :SignupPresenterProtocol) {
        self.presenter = presenter
    }
    
    func registerNewUser(user: User) {
        let networkobject = NetworkDAL.sharedInstance()
        networkobject.processPostReq(withBaseUrl: ApiBaseUrl.mainApi,andUrlSuffix: SuffixUrl.signup.rawValue,andParameters: user.getUserDataInDictionary(),onSuccess: onRegisterSucsess,onFailure: onRegisterFailure)
    }
    
    
    func onRegisterFailure(data: Any) {
        presenter.alertToShow(withTitle: "Error", andMessage: "Failed to connect")
    }
    
    func onRegisterSucsess(data: Any) {
        let response = data as! [String:Any]
        let msg:String = response["message"] as! String
        if  msg == "sorry this account is not yet verified" {
             let token = response["auth_token"] as! String
            
           
            presenter.goToVerifyScreen(withToken: token)
        }else{
            presenter.alertToShow(withTitle: "Error", andMessage:msg )
    }
}
}
