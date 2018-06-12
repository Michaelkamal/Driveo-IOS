//
//  Order.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
enum OrderStatus:String{
    case sourceLocation = "Pick up location"
    case destinationLocation = "Drop location"
    case orderDetails = "Order details"
    case paymentMethod = "Payment"
}
class Order {
    internal var orderStatus:OrderStatus!
    
    internal var source:OrderLocation?{
        didSet{
            if source!.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderStatus = .sourceLocation
            }
        }
    }
    internal var destination:OrderLocation?{
        didSet{
            if destination!.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderStatus = .destinationLocation
            }
        }
    }
    
    internal var date:String!
    
    internal var providerID:Int!
    
    internal var paymentMethod:PaymentMethod?{
        didSet{
            if oldValue == nil
            {
                completeStatus+=1
                orderStatus = .paymentMethod
            }
        }
    }
   
    
    internal var completeStatus:Int=0
    
    static internal func sharedInstance () ->(Order)
    {
        struct Singleton {
            static let instance = Order();
        }
        
        return Singleton.instance;
        
    }
    
    init(){orderStatus = .sourceLocation }
    
    
    
}
