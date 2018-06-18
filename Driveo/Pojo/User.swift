//
//  User.swift
//  FinalProject
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

struct  User : Decodable{

    var id:Int?
    var name:String?
    var verified: Bool?
    var password:String?
    var phone:String
    var email:String
    var confirmPassword:String?
    var avatar:Image?

    
    init(email: String , phone:String, password:String,confirmPassword:String) {
        self.email=email
         self.phone=phone
         self.password=password
        self.confirmPassword = confirmPassword
    }
    
    init(email: String , phone:String, password:String) {
        self.email=email
        self.phone=phone
        self.password=password
    }
    
    func getUserDataInDictionary()->[String:String]{
        if let confirm = self.confirmPassword {
            return ["email":self.email,"phone":self.phone,"password":self.password!,"confirm_password":self.confirmPassword!]
        }
        else {
            return ["email":self.email,"phone":self.phone,"password":self.password!]
        }
    }
    
}
