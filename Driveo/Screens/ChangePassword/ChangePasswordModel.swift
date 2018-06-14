//
//  ChangePasswordModel.swift
//  Driveo
//
//  Created by Admin on 6/15/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class ChangePasswordModel: ChangePasswordModelProtocol {
    
    var cPP : ChangePasswordPresenterProtocol
    
    init(withPresenter p:ChangePasswordPresenterProtocol) {
        cPP=p
    }
    
    func sendRequest(withParameters params: Dictionary<String, Any>) {
        let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
        let defaults = UserDefaults.standard
        var token = defaults.object(forKey: "auth_token") as! String
        let header = ["authorization" : token]
        
        networkObj.processPatchReq(withBaseUrl: .mainApi, andUrlSuffix: "authentication/changepassword", andParameters: params, onSuccess: onSuccess, onFailure: onFailure,headers: header)
    }
    
    func onSuccess(_ response: Data) {
        
        print(response)
        do{
            let response = try JSONDecoder().decode(GenericResult.self, from: response)
            let msg:String = response.message
            if  msg == MsgResponse.success.rawValue {
                
                cPP.changeSuccess(message:"Password changed")
                
            }else{
                cPP.changeFailure(message: msg)
            }
        }
        catch {
            print("catch")
            print(ErrorType.parse.rawValue)
            cPP.changeFailure(message: "Connection error")
        }
    }
    
    func onFailure(_ networkError: ErrorType) {
        cPP.changeFailure(message: "failed")
    }
    
    
}
