//
//  CreateRequestModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

protocol CreateRequestModelProtocol {
    
    
    func sendCreateRequest(withTitle title: String, withDescription description: String, withImages images: [UIImage], from:String , to:String, provider_id:String, payment_method:String)
    
    func getPhoto(withImage image:Any)
}
