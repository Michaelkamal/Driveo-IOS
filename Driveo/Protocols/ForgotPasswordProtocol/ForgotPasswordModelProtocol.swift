//
//  ForgotPasswordModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol ForgotPasswordModelProtocol {
    
    func sendRequest(withParameters params:Dictionary<String,Any>);
    func onSuccess(_ response:Data) -> Void
    func onFailure(_ networkError:ErrorType) -> Void
}

