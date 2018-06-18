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
    private var view:CreateOrderViewProtocol!
    private lazy var model = NetworkDAL.sharedInstance()
    
    init(withController controller:UIViewController) {
        self.controller=controller
        view=controller as! CreateOrderViewProtocol
    }
    
    internal func sumbitOrder(_ order:Order)
    {
        let defaults = UserDefaults.standard
        var images : [UIImage] = []
        if let orderImages = order.details?.images{
            images+=orderImages
        }
        if let token = defaults.string(forKey: "auth_token"),let JSONData = try? JSONEncoder().encode(order),let dictionary = try? JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) as? [String: Any]
        {
            print(token)
            view.displayProgressBar()
            view.isSubmitted=true
            model.processPostUploadMultiPart(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.order.rawValue, andParameters: dictionary!, onSuccess: { (data) in
            self.view.isSubmitted=false
            self.view.presentToNextScreen()
        },onProgress: { (progress) in
            self.view.updateProgressBar(withValue: progress)
        } ,onFailure: { (err) in
            self.view.showAlert(ofError: ErrorType.internet)
        },headers:["Authorization":token],andImages: images)
        }}
}
