//
//  LoginPresenter.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class LoginPresenter : LoginPresenterProtocol{
    var lvc:LoginViewProtocol
    var lm: LoginModelProtocol!
    init(withController c:LoginViewProtocol) {
        lvc = c
    }
    
    func login(withUserName name:String,andPassword pass:String){
        
        lm = LoginModel(withPresenter: self)
        lm.sendRequest(withUserName : name,andPassword : pass)
        
    }
    
    func loginSuccess(user:User, token:String) ->Void{
        lvc.goToScreen(withScreenName: "next")
        lvc.dismissLoading()
            
    }
    func loginFailure(message:String) -> Void {
        lvc.loginFailed(withMessage: message)
        lvc.dismissLoading()
    }
    
}

