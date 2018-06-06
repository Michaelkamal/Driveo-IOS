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

    private var selectedPaymentMethod:PaymentMethod?{
        didSet{
            userOrder?.paymentMethod=selectedPaymentMethod
        }
    }

private var viewDelagate:PaymentViewProtocol!

private var controller:UIViewController!
    
private var paymentMethods:[PaymentMethod]?

init(withController controller:UIViewController,andOrder order:Order?=nil) {
    self.controller=controller
    self.userOrder=order
    viewDelagate=controller as! PaymentViewProtocol
    
    if let userOrder = self.userOrder {
        selectedPaymentMethod = userOrder.paymentMethod
    }
    else{
       print("")
    }
}
    
    public func didSelectPaymentMethod(paymentMethod method:PaymentMethod)
    
{
    if userOrder != nil{
        selectedPaymentMethod=method
    }
}
    
    public func getPaymentDataArray()
        
    {
        if let paymentMethods = paymentMethods{
            viewDelagate.updateTableViewData(withArray: paymentMethods)
        }else
        {
            paymentMethods=[PaymentMethod(id: 1, name: "Cach On Delivery", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:true),PaymentMethod(id: 2, name: "Cach On Delivery2", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:false),PaymentMethod(id: 3, name: "Cach On Delivery 3", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:false)]
        }
        viewDelagate.updateTableViewData(withArray: paymentMethods!)
    }
    public func submitFunc()
    {
        if (selectedPaymentMethod != nil)  {
            viewDelagate.presentToNextScreen(withOrder: userOrder!)
        }else{
            viewDelagate.showAlert(ofError: .incompleteData)
        }
    }
}
