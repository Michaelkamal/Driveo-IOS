//
//  Order.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

enum OrderCurrentStep:String,Codable {
    case sourceLocation = "Pick up location"
    case destinationLocation = "Drop location"
    case orderDetails = "Order details"
    case paymentMethod = "Payment"
}

enum OrderType :String{
    
    case HistoryOrders = "getHistoryOrders"
    case UpcomingOrders = "Upcoming"
}

enum OrderStatus :String,Codable{
    
    case upComing = "Upcoming"
    case active = "Active"
    case past = "Past"
}

final class Order  {
    
    
    internal var orderID:Double?
    
    internal var orderCurrentStep:OrderCurrentStep!
    
    internal var orderStatus:OrderStatus!
    
    internal var source:OrderLocation?{
        didSet{
            if source!.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderCurrentStep = .sourceLocation
            }
        }
    }
    internal var destination:OrderLocation?{
        didSet{
            if destination!.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderCurrentStep = .destinationLocation
            }
        }
    }
    
    internal var details:OrderDetails?{
        didSet{
            if (oldValue == nil && details!.isComplete())
            {
                completeStatus+=1
                orderCurrentStep = .orderDetails
            }
        }
    }
    internal var date:String!
    
    internal var provider:Provider!
    
    internal var paymentMethod:PaymentMethod?{
        didSet{
            if oldValue == nil
            {
                completeStatus+=1
                orderCurrentStep = .paymentMethod
            }
        }
    }
   
    
    internal var completeStatus:Int=0
    
    static internal func sharedInstance () ->(Order)
    {
        struct Singleton {
            static let instance = Order();
        }
        Singleton.instance.orderStatus = .upComing
        
        return Singleton.instance;
        
    }
    
    init(){orderCurrentStep = .sourceLocation }
    
}
extension Order : Codable{
    // Mark : Encoding and decoding
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case source = "source_location"
        case destination = "destination_location"
        case details = "details"
        case date = "date"
        case provider = "provider"
        case paymentMethod = "payment_method"
        case orderStatus = "order_status"
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderID =  try container.decode(Double.self, forKey: .orderID)
        source = try container.decode(OrderLocation.self, forKey: .source)
        destination = try container.decode(OrderLocation.self, forKey: .destination)
        date =  try container.decode(String.self, forKey: .date)
        provider = try container.decode(Provider.self, forKey: .provider)
        details =  try container.decode(OrderDetails.self, forKey: .details)
        paymentMethod =  try container.decode(PaymentMethod.self, forKey: .paymentMethod)
        if let status = try? container.decode(String.self, forKey: .orderStatus){
            switch status {
            case OrderStatus.upComing.rawValue :
                orderStatus = OrderStatus.upComing
                
            case OrderStatus.active.rawValue :
                orderStatus = OrderStatus.active
                
            case OrderStatus.past.rawValue :
                orderStatus = OrderStatus.past
            default:
                break
            }
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderID, forKey: .orderID)
        try container.encode(orderStatus.rawValue, forKey: .orderStatus)
        try container.encode(source, forKey: .source)
        try container.encode(destination, forKey: .destination)
        try container.encode(date, forKey: .date)
        try container.encode(provider, forKey: .provider)
        try container.encode(details, forKey: .details)
        try container.encode(paymentMethod, forKey: .paymentMethod)
    }
}
