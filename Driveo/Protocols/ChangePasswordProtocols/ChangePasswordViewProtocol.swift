//
//  ChangePasswordViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/15/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol ChangePasswordViewProtocol {
    func goToScreen(withScreenName name:String);
    func showAlert(withTitle title :String , andMessage msg:String)
    func dismissLoading()
}
