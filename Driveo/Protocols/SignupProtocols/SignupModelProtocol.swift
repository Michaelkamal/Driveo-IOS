//
//  SignupModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol SignupModelProtocol {
    
    func registerNewUser(user:User)
    func onRegisterSucsess(data:Data)
    func onRegisterFailure(data:Any)
    
}
