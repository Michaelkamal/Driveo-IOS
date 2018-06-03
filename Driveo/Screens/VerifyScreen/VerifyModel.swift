//
//  VerifyModel.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class  VerifyModel : VerifyModelProtocol {
   
    var presenter:VerifyPresenterProtocol
    init(withPresenter presenter:VerifyPresenterProtocol) {
        self.presenter = presenter
    }

    
    
    
    func sendVerificationCode(withToken token: String, withCode code: String) {
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        var parameters = [String:Any]()
        parameters["code"] = code
        
        networkObject.processPostReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: "verify", andParameters: parameters , onSuccess: onVerifySucces, onFailure: onVerifyFailure)
        
    }
    
    func onVerifySucces(response:Any){
        presenter.OnCodeVerifiedSuccesfuly()
    }
    
    func onVerifyFailure(response:ErrorType){
        presenter.OnCodeVerifyFailure(withmsg: "Failed")
    }
    
    
}
