//
//  CreateRequestModel.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CreateRequestModel:CreateRequestModelProtocol{
    
    var cRP:CreateRequestPresenterProtocol
    
    init(withPresenter p:CreateRequestPresenterProtocol) {
        cRP = p
    }
    
    func getPhoto(withImage image: Any) {
        
    }
    
    func onSuccess(_ response: Any) {
        print("success")
        let dict = response as! Dictionary<String,Any>
        let message = dict["message"] as! String
        cRP.onCreateRequestSuccess(withMessage : message)
    }
    
    func onFailure(_ networkError: ErrorType) {
        print("failed")
        cRP.onCreateRequestFailure(withError: ErrorType.internet.rawValue)
    }
}


