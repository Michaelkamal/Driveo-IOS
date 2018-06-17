//
//  CreateOrderPresenter.swift
//  Driveo
//
//  Created by Admin on 6/17/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class CreateOrderPresenter {
    
    
    private var controller:UIViewController!
    private lazy var model = NetworkDAL.sharedInstance()
    
    init(withController controller:UIViewController) {
        self.controller=controller
    }
    
    internal func sumbitOrder(_ order:Order)
    {
        let JSONData = try? JSONEncoder().encode(order)
        let dictionary = try? JSONSerialization.jsonObject(with: JSONData!, options: .allowFragments) as? [String: Any]
        
        model.processPostReq(withBaseUrl: ApiBaseUrl.usamaTest, andUrlSuffix: "test", andParameters: dictionary!!, onSuccess: { (data) in
            
        }, onFailure: { (err) in
            print(err)
        }, headers: nil)
    }
}
