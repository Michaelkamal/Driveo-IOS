//
//  VerifyPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol VerifyPresenterProtocol {
    
    func sendVerificationCode(withcode code: String,andToken token:String )
    
    func setErrorLabel()
    
    func OnCodeVerifiedSuccesfuly()
    
    func OnCodeVerifyFailure(withmsg msg: String)
    
    
}
