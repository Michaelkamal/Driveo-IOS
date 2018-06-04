//
//  CreateRequestModelProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol CreateRequestModelProtocol {
    
    
    func sendCreateRequest(withTitle title:String, withDescription description:String, withImages imaged : [Any])
    
    func getPhoto(withImage image:Any)
}
