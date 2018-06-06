//
//  ResetPasswordViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol ResetPasswordViewProtocol{
    func goToScreen(withScreenName name:String);
    func ChangeLabel(withString str:String)
    func showAlert(withTitle title :String , andMessage msg:String)

}
