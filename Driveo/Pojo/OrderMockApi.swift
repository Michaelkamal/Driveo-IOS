//
//  OrderMockApi.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation



public struct OrderMock : Decodable {
    
    var date:String
    var price:Double
    var from:String
    var to:String
    var payment:String
    var status:String
    
}
