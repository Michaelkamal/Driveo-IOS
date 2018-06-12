//
//  RequestOrderResult.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

struct RequestOrdersResult : Decodable {

    var message:String
    
    var history_pages:Int
    
    var data:[String:[OrderMock]]
   
    
}
