//
//  ResetPasswordModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol ResetPasswordModelProtocol {
    func sendRequest(withParameters params:Dictionary<String,Any>);
    func onSuccess(_ response:Data) -> Void
    func onFailure(_ networkError:ErrorType) -> Void
}
