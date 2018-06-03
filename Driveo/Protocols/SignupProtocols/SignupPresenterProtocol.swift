//
//  SignupPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol SignupPresenterProtocol {
    
    func isPasswordValid(password: String)
    func isPasswordmatches(password: String, confirmPassword: String)
    func isEmailValid(email: String)
    func isPhoneValid(phone : String)
    func registerclicked(user:User)
    func goToVerifyScreen()
    func alertToShow(withTitle title :String , andMessage msg:String)
    
}
