//
//  ChangePasswordPresenter.swift
//  Driveo
//
//  Created by Admin on 6/15/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    
    var cPC:ChangePasswordViewProtocol
    var cPM:ChangePasswordModelProtocol!
    
    init(withController c:ChangePasswordViewProtocol) {
        cPC = c
    }
    
    func change(oldPassword oldPass:String , withPassword pass1: String) {
        cPM = ChangePasswordModel(withPresenter: self)
        let params = [
            "password" : oldPass,
            "new_password" : pass1]
        cPM.sendRequest(withParameters: params)
    }
    
    func changeSuccess(message: String) {
        cPC.dismissLoading()
        cPC.showAlert(withTitle: "Success", andMessage: message)
    }
    
    func changeFailure(message: String) {
        cPC.dismissLoading()
        cPC.showAlert(withTitle: "Failed", andMessage: message)
    }
}
