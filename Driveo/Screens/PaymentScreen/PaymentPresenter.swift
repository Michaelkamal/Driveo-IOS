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
            // TODO : Get payment method from API
            paymentMethods=[PaymentMethod(id: 1, name: "Cash", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:true),PaymentMethod(id: 2, name: "Cach On Delivery2", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:false),PaymentMethod(id: 3, name: "Cach On Delivery 3", image:Image(url:"https://www.royalmint.com/globalassets/the-royal-mint/images/pages/discover/uk-coins/coins-designs-and-specifications/fifty-pence-coin/50_pence_1969.jpg?width=103&quality=50") , isSelected: false,isEnable:false)]
        }
        viewDelagate.updateTableViewData(withArray: paymentMethods!)
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
