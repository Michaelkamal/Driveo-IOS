//
//  ForgotPassPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol ForgotPassPresenterProtocol {
    func sendLink(withEmail mail:String)
    func sendSuccess(message:String) ->Void
    func sendFailure(message:String) -> Void
}

