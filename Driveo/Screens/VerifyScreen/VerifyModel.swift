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
        parameters["verification_pin"] = code
        
        networkObject.processPatchReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.verify.rawValue, andParameters: parameters , onSuccess: onVerifySucces, onFailure: onVerifyFailure,headers: ["Authorization":token])
        }
    
    func onVerifySucces(response:Data){
            do{
                let response = try JSONDecoder().decode(GenericResult.self, from: response)
                let msg:String = response.message
                        if  msg == MsgResponse.success.rawValue {
                           presenter.OnCodeVerifiedSuccesfuly()
                        }else{
                            presenter.OnCodeVerifyFailure(withmsg: msg)
                        }
            }
            catch {
                presenter.OnCodeVerifyFailure(withmsg: ErrorType.internet.rawValue)
                print("catch")
                print(ErrorType.parse.rawValue)
            }
    }
    
    func onVerifyFailure(response:ErrorType){
        presenter.OnCodeVerifyFailure(withmsg: "Failed")
    }
    
    func requestVerificationCode(forToken token:String){
        let networkObject : NetworkDAL = NetworkDAL.sharedInstance()
        let parameters = [String:Any]()
        
        networkObject.processPostReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.resendVerificatoin.rawValue, andParameters: parameters , onSuccess: onResendVerifySucces, onFailure: onVerifyFailure,headers: ["Authorization":token])
    }
    
   
    func onResendVerifySucces(response:Data){
        do{
            let response = try JSONDecoder().decode(GenericResult.self, from: response)
            let msg:String = response.message
            if  msg == MsgResponse.success.rawValue {
            presenter.onAskForVerificationCodeSuccess()
            }else{
                presenter.OnCodeVerifyFailure(withmsg: msg)
            }
        }
        catch {
            presenter.OnCodeVerifyFailure(withmsg: ErrorType.internet.rawValue)
            print("catch")
            print(ErrorType.parse.rawValue)
        }
        
        
        
        
    }
    
    
    
    
    
}
