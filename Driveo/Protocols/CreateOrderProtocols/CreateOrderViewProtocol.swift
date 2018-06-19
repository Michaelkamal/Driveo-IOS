//
//  CreateOrderViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/17/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol CreateOrderViewProtocol:GenericProtocol {
    var isSubmitted:Bool{set get}
    func displayProgressBar()
    func updateProgressBar(withValue value:Double)
    func removeProgressBar()
    func showAlert(withTitle title :String , andMessage msg:String)
}
