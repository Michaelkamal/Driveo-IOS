//
//  VerifyPresenter.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class VerifyPresenter : VerifyPresenterProtocol{
    
    lazy var verifyModel = VerifyModel(withPresenter: self)
   
    var verifyView:VerifyViewProtocol
    
    var errorText:String=""{
        didSet{
           verifyView.setCodeErrorLabel(withError: errorText)
        }
    }
    
    init(view:VerifyViewProtocol) {
        verifyView = view
    }
    
    func sendVerificationCode(withcode code: String) {
        if code.matches("^\\d{4}$"){
            
                    if NetworkDAL.isInternetAvailable()
                    {
                        let defaults = UserDefaults.standard
                        let token = defaults.string(forKey: "auth_token")
                            if token != nil {
                                verifyView.showLoading()
                                verifyModel.sendVerificationCode(withToken: token!, withCode: code)
                            }
                    }
                    else{
                        
                        verifyView.showAlert(withTitle: ErrorType.errorTitle.rawValue, andMsg: ErrorType.internet.rawValue)
                    }
        }else{
             errorText = ErrorType.pinCodeError.rawValue
        }
    }
    
    func isCodeValid(withCode code: String){
        if code.matches("^\\d{4}$"){
            errorText = ""
        }else{
            errorText = ErrorType.pinCodeError.rawValue
        }
    }
    
    
    func OnCodeVerifiedSuccesfuly() {
        verifyView.dismissLoading()
        verifyView.goToHomeScreen()
    }
    
    func OnCodeVerifyFailure(withmsg msg: String) {
        verifyView.dismissLoading()
        verifyView.showAlert(withTitle: ErrorType.errorTitle.rawValue, andMsg: msg)
    }
    
    func askForVerificationCode(forToken token:String){
        let defaults = UserDefaults.standard
        if NetworkDAL.isInternetAvailable() {
            if let token = defaults.string(forKey: "auth_token"){
                verifyView.showLoading()
                verifyModel.requestVerificationCode(forToken: token)
            }
        }else {
                     verifyView.showAlert(withTitle: ErrorType.errorTitle.rawValue, andMsg: ErrorType.internet.rawValue)
                    }

    }

    func onAskForVerificationCodeSuccess(){
        verifyView.dismissLoading()
    }
    
}
