//
//  LoginPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol LoginPresenterProtocol {
    func login(withUserName name:String,andPassword pass:String)
    func loginSuccess(user:User, token:String) ->Void
    func loginFailure(message:String) -> Void
}

