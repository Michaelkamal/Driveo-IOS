//
//  CreateRequestPresenterProtocol.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol CreateRequestPresenterProtocol {
    
    func createRequestclicked(withTitle title:String, withDescription :String, withImages: [Any])
    
    func addPhoto(withPhoto photo:Any)
    
    func deletePhoto(withPhoto photo:Any)
    
    func getPhoto()
    
    func onCreateRequestSuccess()
    
    func onCreateRequestFailure(withError error:String)
    
    
    
    
}
