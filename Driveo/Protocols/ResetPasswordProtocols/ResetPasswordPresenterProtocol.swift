//
//  ResetPasswordPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol ResetPasswordPresenterProtocol {
    func resetPassword(withPassword pass1: String, andRepeatedPass repPass:String) 
    func resetSuccess(message:String) ->Void
    func resetFailure(message:String) -> Void
}
