//
//  UserDAL.swift
//  Driveo
//
//  Created by Admin on 6/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
public class UserDAL{
    
    let userDefaults = UserDefaults.standard
    var user:User?
    static internal func sharedInstance () ->(UserDAL)
    {
        struct Singleton {
            static let instance = UserDAL();
        }
        
        return Singleton.instance;
        
    }
    private init(){}
    
    func getUser()->User?{
        if  user==nil{
            if let userData = userDefaults.data(forKey: "user"),
                let user = try? JSONDecoder().decode(User.self, from: userData) {
                self.user=user
            }
        }
        return user
    }
    func saveUser(user:User){
        self.user = user
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: "user")
            userDefaults.synchronize()
        }
    }
    func deleteUser(){
        userDefaults.removeObject(forKey: "user")
        userDefaults.synchronize()
    }
}
