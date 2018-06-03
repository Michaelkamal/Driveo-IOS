//
//  SignupViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol SignupViewProtocol {
    
    func  setEmailAlertLabel(errorMsg : String)
    func  setPhoneAlertLabel(errorMsg : String)
    func  setPasswordAlertLabel(errorMsg : String)
    func  setConfirmPasswordAlertLabel(errorMsg : String)
    func showLoading()
    func dismissLoading()
    func showNoInternetAlert()
    func goToVerifyScreen()
    func showAlert(withTitle title :String , andMessage msg:String)
}
