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
    
    func sendCreateRequest(withTitle title: String, withDescription description: String, withImages images: [UIImage], from:String , to:String, provider_id:String, payment_method:String) {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "auth_token")

        var header:HTTPHeaders
        if token != nil {
            header = ["Authorization" : token] as! HTTPHeaders

           
            var base64Array = [Data]()
            for img:UIImage in images{
                let pngImg = UIImagePNGRepresentation(img) as! Data
                let base64Img = pngImg.base64EncodedData()
                base64Array.append(base64Img)
            }
            
            let params = ["title" : title,
                "description" : description,
                "images" : base64Array,
                "from" : "from",
                "to" : "to",
                "provider_id" : "1",
                "payment_method" : "cash"] as [String : Any]
            
            let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
            networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: "orders", andParameters: params, onSuccess: onSuccess(_:), onFailure: onFailure(_:), headers: header)
        }
        
        
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
    }
    
    
    
   
    
    
}
