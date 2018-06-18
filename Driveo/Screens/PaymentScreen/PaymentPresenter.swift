//
//  PaymentPresenter.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class PaymentPresenter{
    
public var userOrder:Order=Order.sharedInstance()

    private var selectedPaymentMethod:PaymentMethod?{
        didSet{
            userOrder.paymentMethod=selectedPaymentMethod
        }
    }

private var viewDelagate:PaymentViewProtocol!

private var controller:UIViewController!
    
private var paymentMethods:[PaymentMethod]?

private lazy var model = NetworkDAL.sharedInstance()
    
init(withController controller:UIViewController) {
    self.controller=controller
    viewDelagate=controller as! PaymentViewProtocol
    selectedPaymentMethod = userOrder.paymentMethod
}
    
    public func didSelectPaymentMethod(paymentMethod method:PaymentMethod)
    
{
        selectedPaymentMethod=method
}
    
    public func getPaymentDataArray()
        
    {
        if let paymentMethods = paymentMethods{
            viewDelagate.updateTableViewData(withArray: paymentMethods)
        }else
        {
            
            viewDelagate.showLoading()
            let defaults = UserDefaults.standard
            if let token = defaults.string(forKey: "auth_token") {
                NetworkDAL.sharedInstance().processReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.payment.rawValue, withParser: { (JSON) -> [Any] in
                    var res:[Any]=[]
                    if let paymentMethods = try? JSONDecoder().decode(PaymentMethods.self, from: JSON.rawData()) {
                        if let methodsArray = paymentMethods.paymentMethods{
                            res += methodsArray as [Any]
                        }
                    }
                    else
                    {
                        self.viewDelagate.showAlert(ofError: ErrorType.parse)
                    }
                    return res
                },andHeaders:["Authorization":token],
                  onSuccess: { (paymentMethods) in
                    if let paymentMethods = paymentMethods as? [PaymentMethod]{
                       self.viewDelagate.updateTableViewData(withArray: paymentMethods)
                        self.paymentMethods=paymentMethods
                    }
                }, onFailure: { err  in
                    print(err)
                    self.viewDelagate.showAlert(ofError: ErrorType.internet)
                })
            }
        }
    }
    public func submitFunc()
    {
        if (selectedPaymentMethod != nil)  {
            viewDelagate.presentToNextScreen()
        }else{
            viewDelagate.showAlert(ofError: .incompleteData)
        }
    }
}
