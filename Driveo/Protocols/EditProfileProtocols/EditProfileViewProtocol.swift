//
//  EditProfileViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/18/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol EditProfileProtocol : GenericProtocol{
    func  setEmailAlertLabel(errorMsg : String)
    func  setPhoneAlertLabel(errorMsg : String)
    func showLoading()
    func dismissLoading()
}
