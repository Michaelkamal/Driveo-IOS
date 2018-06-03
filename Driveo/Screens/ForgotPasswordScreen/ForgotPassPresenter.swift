//
//  ForgotPassPresenter.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class ForgotPassPresenter : ForgotPassPresenterProtocol {
    
    var fPC:ForgotPassViewProtocol
    var fPM : ForgotPasswordModelProtocol!
    init(withController c:ForgotPassViewProtocol) {
        fPC = c
    }
    
    func sendLink(withEmail mail:String){
        
        fPM = ForgotPassModel(withPresenter: self)
        let params = [
            "email" : mail]
        fPM.sendRequest(withParameters: params)
        
    }
    
    
    func sendSuccess(message:String) ->Void {
        fPC.ChangeLabel(withString: message)
    }
    
    func sendFailure(message: String) -> Void {
        
    }
    
}
