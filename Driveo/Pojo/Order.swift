//
//  Order.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import CoreLocation
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
            if let source=source{
            if source.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderCurrentStep = .sourceLocation
            }
            }}
    }
    internal var destination:OrderLocation?{
        didSet{
            
            if let destination=destination{
            if destination.isComplete(),oldValue == nil
            {
                completeStatus+=1
                orderCurrentStep = .destinationLocation
            }
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
    
    internal var price:Double?
    
    internal var weight:Double?=10.0
    
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
    internal func nullifyOrder(){
        orderID=nil
        orderCurrentStep=OrderCurrentStep.sourceLocation
        orderStatus = .upComing
        source=nil
        destination=nil
        details=nil
        price=nil
        weight=10.0
        provider.id=nil
        provider.name=nil
        provider.rating=nil
        provider.image=nil
        completeStatus=0
    }
    
}
extension Order : Codable{
    // Mark : Encoding and decoding
    enum CodingKeys: String, CodingKey {
        case orderID = "id"
        case title = "title"
        case description = "description"
        case sourceLongitude = "src_longitude"
        case sourceLatitude = "src_latitude"
        case sourceAddress = "pickup_location"
        case destinationLongitude = "dest_longitude"
        case destinationLatitude = "dest_latitude"
        case destinationAddress = "dropoff_location"
        case date = "time"
        case provider = "provider_id"
        case paymentMethod = "payment_method"
        case images = "images"
        case weight = "weight"
        case price = "price"
        case orderStatus = "status"
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderID =  try container.decode(Double.self, forKey: .orderID)
        source = OrderLocation()
        source!.coordinates = CLLocation(
            latitude: try container.decode(Double.self, forKey: .sourceLatitude),
            longitude: try container.decode(Double.self, forKey: .sourceLongitude))
        source!.address = try container.decode(String.self, forKey: .sourceAddress)
        destination = OrderLocation()
        destination!.coordinates = CLLocation(
            latitude: try container.decode(Double.self, forKey: .destinationLatitude),
            longitude: try container.decode(Double.self, forKey: .destinationLongitude))
        destination!.address = try container.decode(String.self, forKey: .destinationAddress)
        date =  try container.decode(String.self, forKey: .date)
        provider = Provider()
        provider.id = try container.decode(Int.self, forKey: .provider)
        details = OrderDetails()
        details!.title =  try container.decode(String.self, forKey: .title)
        details!.description =  try container.decode(String.self, forKey: .description)
        details!.imagesURL =  try container.decode(Array<String>.self, forKey: .images)
        paymentMethod = PaymentMethod()
        paymentMethod!.name =  try container.decode(String.self, forKey: .paymentMethod)
        weight = try container.decode(Double.self, forKey: .weight)
        price = try container.decode(Double.self, forKey: .price)
       
        if let status = try? container.decode(String.self, forKey: .orderStatus){
            switch status {
            case "pending" :
                orderStatus = OrderStatus.upComing
                
            case OrderStatus.active.rawValue :
                orderStatus = OrderStatus.active
                
            case "history" :
                orderStatus = OrderStatus.past
            default:
                break
            }
 
        }
 
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderID, forKey: .orderID)
        try container.encode(details?.title, forKey: .title)
        try container.encode(details?.description, forKey: .description)
        try container.encode(source?.coordinates?.coordinate.latitude, forKey: .sourceLatitude)
        try container.encode(source?.coordinates?.coordinate.longitude, forKey: .sourceLongitude)
        try container.encode(source?.address, forKey: .sourceAddress)
        try container.encode(destination?.coordinates?.coordinate.latitude, forKey: .destinationLatitude)
        try container.encode(destination?.coordinates?.coordinate.longitude, forKey: .destinationLongitude)
        try container.encode(destination?.address, forKey: .destinationAddress)
        try container.encode(date, forKey: .date)
        try container.encode(provider.id, forKey: .provider)
        try container.encode(paymentMethod?.name, forKey: .paymentMethod)
        try container.encode(price, forKey: .price)
        try container.encode(weight, forKey: .weight)
    }
}
