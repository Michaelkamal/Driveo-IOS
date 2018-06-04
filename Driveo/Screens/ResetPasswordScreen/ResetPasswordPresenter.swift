//
//  ResetPasswordPresenter.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class ResetPasswordPresenter: ResetPasswordPresenterProtocol {
    
    var rPC:ResetPasswordViewProtocol
    var rPM : ResetPasswordModelProtocol!
    init(withController c:ResetPasswordViewProtocol) {
        rPC = c
    }
    
    func resetPassword(withPassword pass1: String) {
        rPM = ResetPasswordModel(withPresenter: self)
        let params = [
            "password" : pass1]
        rPM.sendRequest(withParameters: params)
    }
    
    func resetSuccess(message:String) {
        rPC.ChangeLabel(withString: message)
    }
    
    func resetFailure(message: String) {
        
    }
    
    
}
