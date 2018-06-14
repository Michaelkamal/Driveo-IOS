//
//  ChangePasswordPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/15/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol ChangePasswordPresenterProtocol {
    func change(oldPassword oldPass:String , withPassword pass1: String)
    func changeSuccess(message:String) ->Void
    func changeFailure(message:String) -> Void
}
