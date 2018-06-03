//
//  Order.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class Order {

    internal var source:OrderLocation!{
        didSet{
            if source!.isComplete()
            {
                completeStatus+=1
            }
            else{
                source=nil
            }
        }
    }
    
    internal var date:String!
    
    internal var carrier:String!
    
    internal var destination:OrderLocation?{
        didSet{
            if destination!.isComplete()
            {
                completeStatus+=1
            }
            else{
                destination=nil
            }
        }
    }
    
    
    init(withSource source:OrderLocation,byCarrier carrier:String,onDate date:String) {
        self.source = source
        self.carrier=carrier
        self.date = date
    }
    
    internal var completeStatus:Int=0
    
}
