//
//  LoginModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol LoginModelProtocol {
    func sendRequest(withUserName name:String,andPassword pass:String);
    func onSuccess(_ response:Data) -> Void
    func onFailure(_ networkError:ErrorType) -> Void
}

