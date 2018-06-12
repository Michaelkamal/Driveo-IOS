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
    
    func onSuccess(_ response: Data) {
        
        print(response)
        do{
            let response = try JSONDecoder().decode(ForgotPasswordResult.self, from: response)
            let msg:String = response.message
            if  msg == MsgResponse.forgotSuccess.rawValue {
                fPP.sendSuccess(message: msg)
                
            }else{
                fPP.sendFailure(message: msg)
            }
        }
        catch {
            print("catch")
            print(ErrorType.parse.rawValue)
            fPP.sendFailure(message: "Connection error")
        }

    }
    
    func onFailure(_ networkError: ErrorType) {
        fPP.sendFailure(message: "Connection error")
    }
    
}
