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
    case paymentMethod = "Payment"
}
class Order {
    
    internal var orderStatus:OrderStatus?
    
    internal var source:OrderLocation!
    
    internal var date:String!
    
    internal var providerID:Int!
    
    internal var paymentID:Int!{
        didSet{
            if oldValue == nil
            {
                completeStatus+=1
                orderStatus = .paymentMethod
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
    
    
    init(withSource source:OrderLocation,byCarrier providerID:Int,onDate date:String) {
        self.source = source
        completeStatus+=1
        self.providerID=providerID
        self.date = date
    }
    
    internal var completeStatus:Int=0
    
}
