//
//  LoginViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol LoginViewProtocol {
    func goToScreen(withScreenName name:String);
    func showErrorLabel(withString str:String)
    func showAlert(withTitle title :String , andMessage msg:String)
    func dismissLoading()
}
