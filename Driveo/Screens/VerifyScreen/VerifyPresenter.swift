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
            verifyView.showLoading()
                    if NetworkDAL.isInternetAvailable()
                    {
                        let defaults = UserDefaults.standard
                        let token = defaults.string(forKey: "auth_token")
                            if (token != nil) {
                                verifyModel.sendVerificationCode(withToken: token!, withCode: code)
                            }
                    }
                    else{
                        verifyView.dismissLoading()
                        verifyView.showAlert(withTitle: "Error", andMsg: ErrorType.internet.rawValue)
                    }
        }else{
             errorText = "Please enter Valid Code"
        }
       
    }
    
    func isCodeValid(withCode code: String){
        if code.matches("^\\d{4}$"){
            errorText = ""
        }else{
            errorText = "Please enter Valid Code"
        }
    }
    
    func OnCodeVerifiedSuccesfuly() {
        verifyView.dismissLoading()
        verifyView.goToHomeScreen()
    }
    
    func OnCodeVerifyFailure(withmsg msg: String) {
        verifyView.dismissLoading()
        verifyView.showAlert(withTitle: "Error", andMsg: msg)
    }
    
    
}
