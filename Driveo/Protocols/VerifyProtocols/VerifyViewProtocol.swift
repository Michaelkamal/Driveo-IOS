//
//  VerifyViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol VerifyViewProtocol {
    
    func setCodeErrorLabel (withError error: String)
    
    func showLoading()
    
    func dismissLoading()
    
    func goToHomeScreen()
    
    func showAlert(withTitle title:String , andMsg msg:String)
    
}
