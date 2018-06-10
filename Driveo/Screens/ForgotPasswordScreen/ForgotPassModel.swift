//
//  ForgotPassModel.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
//
//  ForgetPassModel.swift
//  FinalProject
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Alamofire

class ForgotPassModel : ForgotPasswordModelProtocol{

    
    var fPP:ForgotPassPresenterProtocol
    
    init(withPresenter p:ForgotPassPresenterProtocol) {
        fPP = p
    }
    
    func sendRequest(withParameters params:Dictionary<String,Any>){
        let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
        let header = HTTPHeaders()
        
        networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "authentication/forgotpassword", andParameters: params, onSuccess: onSuccess(_:), onFailure: onFailure(_:))
    }
    
    func onSuccess(_ response: Any) {
        
        let dict = response as! Dictionary<String,Any>
        let message = dict["message"] as! String
        if message.contains("success") {
            fPP.sendSuccess(message: "A reset link has been sent to your email")
        }
        else{
            fPP.sendFailure(message: message)
        }
    }
    
    func onFailure(_ networkError: ErrorType) {
        fPP.sendFailure(message: "Connection error")
    }
    
}
