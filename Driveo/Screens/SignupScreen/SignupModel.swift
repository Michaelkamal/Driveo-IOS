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
    
    func registerNewUser(user: User, onSuccess: () -> Void, onFailure: () -> Void) {
        let networkobject = NetworkDAL.sharedInstance()
        networkobject.processPostReq(withBaseUrl: ApiBaseUrl.mainApi,andUrlSuffix: "signup",andParameters: user.getUserDataInDictionary(),onSuccess: nil,onFailure: nil)
    }
    
    
    func onSucsess(data: Any) {
            }
    
    func onFailure(data: Any) {
        
    }
    
    
    
    
    
    
    
}
