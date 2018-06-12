//
//  SignupResult.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

struct SignupResult : Decodable{
    
    var message:String
    var auth_token:String
    var user:User
    
}

struct SigninResult : Decodable{
    
    var message:String
    var auth_token:String
    var user:User?
    
}

struct ForgotPasswordResult : Decodable{
    
    var message:String
    
}
