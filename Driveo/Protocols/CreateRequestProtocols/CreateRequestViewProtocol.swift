//
//  CreateRequestViewProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol CreateRequestViewProtocol {
    
    
    func showLoading()
    func dismissLoading()
    func showAlert(withTitle title : String , withMsg msg:String)
    func goToNextScreen()
    func getNewImage()
    func updateImages()
}
