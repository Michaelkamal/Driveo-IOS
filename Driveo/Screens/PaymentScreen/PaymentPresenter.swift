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
    
public var userOrder:Order?

private var selectedPaymentMethodID:Int?

private var viewDelagate:PaymentViewProtocol!

private var controller:UIViewController!
    
private var paymentMethods:[PaymentMethod]=[]

init(withController controller:UIViewController,andOrder order:Order?=nil) {
    self.controller=controller
    self.userOrder=order
    viewDelagate=controller as! PaymentViewProtocol
    
    if let userOrder = self.userOrder {
       selectedPaymentMethodID=userOrder.paymentID
    }
    else{
       print("")
    }
}
    
    public func didSelectPaymentMethod(paymentMethodID id:Int)
    
{
    if let userOrder = userOrder{
        userOrder.paymentID=id
    }
}
    
    public func getPaymentDataArray() -> [PaymentMethod]
        
    {
        return paymentMethods
    }
}
